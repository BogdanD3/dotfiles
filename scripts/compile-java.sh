#!/bin/bash

CONTENT="
javac -d target/classes src/main/java/com/myapp/*.java
java -cp target/classes com.myapp.App
"

if command -v wl-copy &> /dev/null; then
    echo "$CONTENT" | wl-copy
elif command -v xclip &> /dev/null; then
    echo "$CONTENT" | xclip -selection clipboard
else
    echo "No clipboard tool found. Install wl-copy or xclip."
    exit 1
fi

echo "Java commands copied to clipboard!"
