#!/usr/bin/sh
pluged_in_alarm="beyond-doubt-2-581.ogg"
warning_alarm="open-up-587.ogg"
fullcharge=100


warning_level=20
dangerlevel=16
full_charge=16
# How often to check battery status, in minutes
check_interval=2

while true; do
  battery_level=$(acpi -b | cut -d, -f2 | cut --characters=2,3,4 | sed 's/%//g')

  charging=$(acpi -b | grep -c "Charging")
  # When battery is low, and not already charging
  if [ $battery_level -eq $warning_level ] && [ $charging -eq 0 ]
   then
    play -q -v 0.40 "$warning_alarm" -t alsa &
    notify-send " Low battery: ${battery_level}% " \
    " Plug into mains power " -t 8000
  elif [ $battery_level -lt $dangerlevel ] && [ $charging -eq 0 ]
  then
    play -q -v 0.40 "$warning_alarm" -t alsa &
    notify-send " Low battery: ${battery_level}% " \
    " Plug into mains power " -t 8000
  elif [ $battery_level -ge $full_charge ] && [ $charging -eq 1 ]
  then
    play -q -v 0.40 "$warning_alarm" -t alsa &
    notify-send " Buttery is Full: ${battery_level}% " \
    " Please Unplug youe charger adapter " -t 8000
  fi

  sleep ${check_interval}m
done


