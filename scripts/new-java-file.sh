#!/bin/bash

BASE_DIR="$HOME/PMF/JavaPractise"

if [ -n "$1" ]; then
    DEST_DIR="$1"
else
    PROJECT_NAME=$(rofi -dmenu -p "Project Name (empty = current folder)")
    if [ -z "$PROJECT_NAME" ]; then
        DEST_DIR="$PWD"
    else
        DEST_DIR="$BASE_DIR/$PROJECT_NAME/src/main/java/com/myapp"
        [ ! -d "$DEST_DIR" ] && echo "Project not found." && exit 1
    fi
fi

if [[ "$DEST_DIR" == *"src/main/java/com/myapp"* ]]; then
    PACKAGE="package com.myapp;"
else
    PACKAGE=""
fi

FILE_NAME=$(rofi -dmenu -p "Java File Name (without .java)")
[ -z "$FILE_NAME" ] && exit 0

FILE_PATH="$DEST_DIR/$FILE_NAME.java"

[ -f "$FILE_PATH" ] && echo "File already exists." && exit 1

mkdir -p "$DEST_DIR"

{
[ -n "$PACKAGE" ] && echo "$PACKAGE" && echo
echo "public class $FILE_NAME {"
echo
echo "    public static void main(String[] args) {"
echo "        "
echo "    }"
echo
echo "}"
} > "$FILE_PATH"

nvim "$FILE_PATH"
