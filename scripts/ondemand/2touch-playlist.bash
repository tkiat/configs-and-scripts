#!/usr/bin/env bash
MUSIC=".pcm$|.wav$|.aiff$|.flac$|.alac$|.mp3$|.aac$|.ogg$|.wma"
MOVIE=".mp4"
ls | grep -E "$MUSIC|$MOVIE" > 00-Playlist.m3u
