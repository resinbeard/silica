#! /bin/bash
/usr/bin/tmux new-session -s "silica-audio" -d
oscsend localhost 9456 /silica/display/startup_system_process si "linux 4.14.83-gentoo" 0

tmux send "jackd -d alsa -d hw:D16A" C-m
tmux rename-window "jackd"
oscsend localhost 9456 /silica/display/startup_system_process si "jackd -d alsa -d hw:D16A" 0

sleep 1;

tmux split-window
tmux send "serialoscd" C-m
tmux rename-window "serialosc"
oscsend localhost 9456 /silica/display/startup_system_process si "serialosd" 0

sleep 1;

tmux split-window
tmux send "~/Dev/candor -pa samples -pr test -m 16824 -cc" C-m
tmux rename-window "candor"
oscsend localhost 9456 /silica/display/startup_system_process si "candor -pa samples -pr test -m 16824 -cc" 0

sleep 1;

tmux split-window
tmux send "~/Dev/cyperus -i 4 -o 4" C-m
tmux rename-window "cyperus"
oscsend localhost 9456 /silica/display/startup_system_process si "cyperus -i 4 -o 4" 0
