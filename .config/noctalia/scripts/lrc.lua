barWidget.setUpdateInterval(300)

function update()
	if not noctalia.commandExists("lrc_tty") then
		return
	end

	noctalia.runAsync("playerctl status --player spotify 2>/dev/null", function(r)
		if r.exitCode == 0 and r.stdout:gsub("%s+$", "") == "Playing" then
			fetchLyrics("spotify")
			return
		end
		noctalia.runAsync("playerctl status --player mpd 2>/dev/null", function(r2)
			if r2.exitCode == 0 and r2.stdout:gsub("%s+$", "") == "Playing" then
				fetchLyrics("mpd")
				return
			end
			barWidget.setText("")
		end)
	end)
end

function fetchLyrics(player)
	noctalia.runAsync("lrc_tty --raw --player " .. player, function(r)
		if r.exitCode == 0 then
			local text = r.stdout:gsub("%s+$", "")
			if #text > 0 and text ~= "(no lyrics)" then
				barWidget.setText("| " .. text)
				return
			end
		end
		barWidget.setText("")
	end, 30000)
end
