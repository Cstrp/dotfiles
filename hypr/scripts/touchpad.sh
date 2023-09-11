#!/bin/bash

# Имя тачпада (замените на фактическое имя вашего тачпада)
TOUCHPAD_NAME="ELAN1203:00 04F3:307A"

export STATUS_FILE="$XDG_RUNTIME_DIR/touchpad.status"

enable_touchpad() {
  printf "true" >"$STATUS_FILE"
  notify-send -u normal "Enabling Touchpad"

  # Находим устройство по имени и включаем его
  DEVICE_ID=$(libinput list-devices | grep -i "$TOUCHPAD_NAME" | grep -o 'event[0-9]\+')
  if [ -n "$DEVICE_ID" ]; then
    libinput debug-events --enable-device "$DEVICE_ID"
  fi
}

disable_touchpad() {
  printf "false" >"$STATUS_FILE"
  notify-send -u normal "Disabling Touchpad"

  # Находим устройство по имени и выключаем его
  DEVICE_ID=$(libinput list-devices | grep -i "$TOUCHPAD_NAME" | grep -o 'event[0-9]\+')
  if [ -n "$DEVICE_ID" ]; then
    libinput debug-events --disable-device "$DEVICE_ID"
  fi
}

if ! [ -f "$STATUS_FILE" ]; then
  enable_touchpad
else
  if [ $(cat "$STATUS_FILE") = "true" ]; then
    disable_touchpad
  elif [ $(cat "$STATUS_FILE") = "false" ]; then
    enable_touchpad
  fi
fi
