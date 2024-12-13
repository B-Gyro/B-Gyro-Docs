#!/bin/bash

# Check if project path is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <project_path>"
	exit 1
fi

PROJECT_PATH=$1

# Activate the virtual environment
source "$PROJECT_PATH/venv/bin/activate"

# Start mkdocs server and log output
nohup mkdocs serve > "$PROJECT_PATH/mkdocs.log" 2>&1 &
echo "MkDocs server started and logging to $PROJECT_PATH/mkdocs.log"
