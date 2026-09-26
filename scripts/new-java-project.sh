#!/bin/bash

# Ask for project name via rofi
PROJECT_NAME=$(echo "" | rofi -dmenu -p "Java Project Name:")

# Cancel if empty
if [ -z "$PROJECT_NAME" ]; then
    exit 0
fi

BASE_DIR="$HOME/PMF/JavaPractise"
PROJECT_DIR="$BASE_DIR/$PROJECT_NAME"

# Create base folder if it doesn't exist
mkdir -p "$BASE_DIR"

# Generate Maven project
mvn archetype:generate \
  -DgroupId=com.myapp \
  -DartifactId="$PROJECT_NAME" \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false \
  -Dpackage=com.myapp \
  -DoutputDirectory="$BASE_DIR"

# Open Neovim in the main App.java
nvim "$PROJECT_DIR/src/main/java/com/myapp/App.java"
