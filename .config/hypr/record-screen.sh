#!/bin/env bash

FRAMERATE=30
OUTPUT_DIR="$HOME/Videos"
TEMP_VIDEO="/tmp/wf-recorder-temp.mp4"

# Проверка необходимых утилит
for cmd in wf-recorder slurp ffmpeg wl-copy; do
    if ! command -v "$cmd" &>/dev/null; then
        notify-send -u critical "$cmd not found" "Please install $cmd."
        exit 1
    fi
done

# Если запись уже идет - останавливаем и конвертируем
if pgrep -x "wf-recorder" >/dev/null; then
    pkill -INT -x wf-recorder
    notify-send -t 2000 "⏹️ Recording Stopped" "Processing GIF..."

    # Ждем завершения записи
    while pgrep -x "wf-recorder" >/dev/null; do
        sleep 0.1
    done

    if [ ! -f "$TEMP_VIDEO" ]; then
        notify-send -u critical "❌ No Recording" "Temporary video not found"
        exit 1
    fi

    # Генерируем имя для GIF
    OUTPUT_GIF="$OUTPUT_DIR/$(date +%m-%d-%Y-%H-%M-%S).gif"

    ffmpeg -y -i "$TEMP_VIDEO" -vf "fps=15,scale=640:-1:flags=lanczos,palettegen" /tmp/palette.png 2>/dev/null
    ffmpeg -y -i "$TEMP_VIDEO" -i /tmp/palette.png \
        -lavfi "fps=15,scale=640:-1:flags=lanczos [x]; [x][1:v] paletteuse" "$OUTPUT_GIF" 2>/dev/null

    # Копирование и уведомление
    if [ -f "$OUTPUT_GIF" ]; then
        wl-copy --type image/gif <"$OUTPUT_GIF"
        notify-send -t 4000 "✅ GIF Saved" "└─ ${OUTPUT_GIF##*/}\n📋 Copied to clipboard!"
        rm -f "$TEMP_VIDEO" /tmp/palette.png
    else
        notify-send -u critical "❌ Conversion Failed" "Failed to create GIF"
        exit 1
    fi

    exit 0
fi

# Начало новой записи
mkdir -p "$OUTPUT_DIR"

GEOMETRY=$(slurp -d -c 3A56C3)
if [ -z "$GEOMETRY" ]; then
    notify-send -u low "⏹️ Recording Canceled" "No area selected"
    exit 0
fi

notify-send -t 1500 "⏺️ Recording Started" "Selected area: $GEOMETRY"
wf-recorder -g "$GEOMETRY" -f "$TEMP_VIDEO" --framerate "$FRAMERATE" &
