#!/usr/bin/env bash
MUSIC=".pcm$|.wav$|.aiff$|.flac$|.alac$|.mp3$|.aac$|.ogg$|.wma"
MOVIE=".mp4"
ls | egrep "$MUSIC|$MOVIE" > 00-Playlist.m3u
