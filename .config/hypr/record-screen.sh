#!/bin/env bash

FRAMERATE=30
OUTPUT_DIR="$HOME/Videos"
DATE_TIME=$(date +%m-%d-%Y-%H:%M:%S)
OUTPUT_FILE="$OUTPUT_DIR/wf-recorder-$DATE_TIME.mkv"

# Проверяем, установлены ли необходимые утилиты
if ! command -v wf-recorder &> /dev/null; then
    notify-send -u critical "wf-recorder not found" "Please install wf-recorder to use this script."
    exit 1
fi

if ! command -v slurp &> /dev/null; then
    notify-send -u critical "slurp not found" "Please install slurp to use this script."
    exit 1
fi

# Проверяем, запущен ли wf-recorder
if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT -x wf-recorder
    notify-send -h string:wf-recorder:record -t 2000 "Recording Finished"
    exit 0
fi

# Убедимся, что папка для записи существует
mkdir -p "$OUTPUT_DIR"

# Выбор области экрана для записи
GEOMETRY=$(slurp)
if [ -z "$GEOMETRY" ]; then
    notify-send -u low "Recording canceled" "No area selected."
    exit 0
fi

# Уведомление о начале записи
notify-send -h string:wf-recorder:record -t 1500 "Started Recording" "Area: $GEOMETRY"

# Запускаем запись
wf-recorder -g "$GEOMETRY" --framerate "$FRAMERATE" --file="$OUTPUT_FILE"
