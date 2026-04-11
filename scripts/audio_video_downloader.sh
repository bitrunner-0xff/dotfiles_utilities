#!/usr/bin/env bash

FLAGS="--no-flat-playlist \
	--no-windows-filenames \
	--no-overwrites \
    --sleep-requests 5 \
	--sleep-interval 15 \
    --max-sleep-interval 30 \
	--continue \
	--part \
	--no-write-info-json \
	--no-quiet \
	--no-ignore-no-formats-error \
	--legacy-server-connect"
VIDEO_FLAGS="--no-write-comments \
	--no-write-thumbnail \
	--no-write-subs"
AUDIO_FLAGS="--extract-audio \
	--audio-format best \
	--audio-quality 0"
# COOKIES="--cookies-from-browser firefox:default-release"
COOKIES="--cookies ~/cookies.txt"
AUDIO_DIR=$HOME/Downloads/Mus
VIDEO_DIR=$HOME/Downloads/Vid
OUTPUT="%(title)s.%(ext)s"
URL="${!#}"

MODE=""

for arg in "$@"; do
    case $arg in
    -h)
        echo -e "Format: audio_video_downloader.sh [Option] URL\nOptions: \n\t-a - Download audio\n\t-v - Download video\n\t-l - List available places to download files\n\t-c - Use your cookies from firefox\n\t-p - Download playlist"
        exit 0
        ;;
    -l)
        yt-dlp --extractor-descriptions
        exit 0
        ;;
    -c)
        FLAGS="${FLAGS} ${COOKIES}"
        ;;
    -p)
        FLAG="${FLAGS} --yes-playlist"
        ;;
    -v)
        MODE="video"
        ;;
    -a)
        MODE="audio"
        ;;
    esac
done

case $MODE in
video)
    mkdir -p $VIDEO_DIR
    yt-dlp $FLAGS $VIDEO_FLAGS --paths $VIDEO_DIR --output $OUTPUT $URL
    ;;
audio)
    mkdir -p $AUDIO_DIR
    yt-dlp $FLAGS $AUDIO_FLAGS --paths $AUDIO_DIR --output $OUTPUT $URL
    ;;
esac
