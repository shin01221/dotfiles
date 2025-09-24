#!/bin/bash
# Allow access to the X server for the current user
xhost +SI:localuser:root
# Run gparted
gparted &
# Wait for gparted to finish
wait $!
# Revoke access to the X server
xhost -SI:localuser:root
