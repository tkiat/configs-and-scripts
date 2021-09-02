#!/usr/bin/env bash
#extract all to folders of the same name
for i in *.zip; do unzip "$i" -d "${i%%.zip}"; done
for i in *.7z; do 7z x "$i" -o${i%%.7z}; done
for i in $(ls | egrep "*.tar.gz$"); do mkdir -p "${i%%.tar.gz}" && tar -xf "$i" --directory "${i%%.tar.gz}"; done # "for i in *.tar.gz" strangely create *.tar.gz folder here
