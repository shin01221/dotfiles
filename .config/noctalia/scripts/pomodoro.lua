barWidget.define({
    label = "Pomodoro",
    version = "2.0.0",
    icon = "clock",
    description = "Pomodoro timer for productivity",
    pickable = true,
    settings = {
        { key = "work_duration", type = "int", label = "Work Duration (min)", default = 25, min = 5, max = 180 },
        { key = "short_break_duration", type = "int", label = "Short Break Duration (min)", default = 5, min = 1, max = 60 },
        { key = "long_break_duration", type = "int", label = "Long Break Duration (min)", default = 15, min = 5, max = 120 },
        { key = "sessions_before_long_break", type = "int", label = "Sessions Before Long Break", default = 4, min = 1, max = 10 },
        { key = "auto_start_breaks", type = "bool", label = "Auto-start Breaks", default = false },
        { key = "auto_start_work", type = "bool", label = "Auto-start Work", default = false },
    },
})

barWidget.setGlyph("clock")
barWidget.setText("")
barWidget.setColor("on_surface")
barWidget.setGlyphColor("on_surface")
barWidget.setVisible(true)
barWidget.setUpdateInterval(1000)

local MODE_WORK = 0
local MODE_SHORT_BREAK = 1
local MODE_LONG_BREAK = 2

local mode = MODE_WORK
local running = false
local remaining = 0
local sessions_done = 0
local alarm_active = false
local alarm_ticks = 0
local ready = false

local function cfg(key, default_)
    return barWidget.getConfig(key, default_)
end

local function settings()
    return {
        work = cfg("work_duration", 25) * 60,
        short = cfg("short_break_duration", 5) * 60,
        long = cfg("long_break_duration", 15) * 60,
        sessions = cfg("sessions_before_long_break", 4),
        auto_break = cfg("auto_start_breaks", false),
        auto_work = cfg("auto_start_work", false),
    }
end

local function dur(m)
    local s = settings()
    if m == MODE_WORK then return s.work end
    if m == MODE_SHORT_BREAK then return s.short end
    if m == MODE_LONG_BREAK then return s.long end
    return s.work
end

local function fmt(sec)
    local h = math.floor(sec / 3600)
    local m = math.floor((sec % 3600) / 60)
    local s = sec % 60
    if h > 0 then return string.format("%02d:%02d:%02d", h, m, s) end
    return string.format("%02d:%02d", m, s)
end

local function icon()
    if alarm_active then return "bell-ringing" end
    if mode == MODE_WORK then return "brain" end
    if mode == MODE_SHORT_BREAK then return "coffee" end
    if mode == MODE_LONG_BREAK then return "bed" end
    return "clock"
end

local function refresh()
    barWidget.setGlyph(icon())
    if running or remaining > 0 or alarm_active then
        if remaining > 0 then
            barWidget.setText(fmt(remaining))
        else
            barWidget.setText("")
        end
        barWidget.setColor("primary")
        barWidget.setGlyphColor("primary")
    else
        barWidget.setText("")
        barWidget.setColor("on_surface")
        barWidget.setGlyphColor("on_surface")
    end
end

local function advance()
    local s = settings()
    if mode == MODE_WORK then
        if sessions_done + 1 >= s.sessions then
            mode = MODE_LONG_BREAK
        else
            mode = MODE_SHORT_BREAK
        end
    else
        if mode == MODE_LONG_BREAK then
            sessions_done = 0
        else
            sessions_done = sessions_done + 1
        end
        mode = MODE_WORK
    end
    remaining = dur(mode)
end

local function finish()
    running = false
    remaining = 0
    alarm_active = true
    alarm_ticks = 0
    local s = settings()
    local msg = ""
    local auto = false
    if mode == MODE_WORK then
        msg = "Work session complete! Time for a break."
        auto = s.auto_break
    elseif mode == MODE_LONG_BREAK then
        msg = "Long break over! Ready for a new cycle?"
        auto = s.auto_work
    else
        msg = "Break over! Ready to focus?"
        auto = s.auto_work
    end
    advance()
    if auto then running = true end
    noctalia.notify("Pomodoro", msg)
    refresh()
end

function update()
    if not ready then
        ready = true
        refresh()
        return
    end
    if alarm_active then
        alarm_ticks = alarm_ticks + 1
        if alarm_ticks >= 5 then alarm_active = false end
    end
    if running then
        remaining = remaining - 1
        if remaining <= 0 then finish() return end
    end
    refresh()
end

function onClick()
    if alarm_active then alarm_active = false refresh() return end
    if running then
        running = false
    else
        if remaining <= 0 then remaining = dur(mode) end
        running = true
    end
    refresh()
end

function onRightClick()
    alarm_active = false
    running = false
    remaining = dur(mode)
    refresh()
end

function onMiddleClick()
    alarm_active = false
    running = false
    advance()
    refresh()
end

function onHover(hovering)
    if not hovering then barWidget.clearTooltip() return end
    local names = { "Work", "Short Break", "Long Break" }
    local status = "Idle"
    if running then status = "Running" end
    if alarm_active then status = "Finished" end
    local s = settings()
    barWidget.setTooltip({
        { key = "Mode", value = names[mode + 1] },
        { key = "Status", value = status },
        { key = "Time", value = fmt(remaining) },
        { key = "Sessions", value = tostring(sessions_done + 1) .. "/" .. tostring(s.sessions) },
    })
end

function onIpc(event, payload)
    if event == "toggle" then
        if running then running = false else if remaining <= 0 then remaining = dur(mode) end running = true end
    elseif event == "start" then
        if remaining <= 0 then remaining = dur(mode) end running = true
    elseif event == "pause" then
        running = false
    elseif event == "reset" then
        running = false alarm_active = false remaining = dur(mode)
    elseif event == "reset-all" then
        running = false remaining = 0 sessions_done = 0 mode = MODE_WORK alarm_active = false
    elseif event == "skip" then
        running = false alarm_active = false advance()
    elseif event == "stop-alarm" then
        alarm_active = false
    end
    refresh()
end
