#!/bin/env bash

if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT -x wf-recorder
    notify-send -h string:wf-recorder:record -t 1000 "Finished Recording"
    exit 0
fi

# Генерируем имя файла с текущей датой и временем
dateTime=$(date +%m-%d-%Y-%H:%M:%S)

# Уведомление о начале записи
notify-send -h string:wf-recorder:record -t 1500 "Started Recording"

# Запускаем запись экрана
wf-recorder -g "$(slurp)" --framerate 30 --file="$HOME/Videos/wf-recorder-$dateTime.mkv"
