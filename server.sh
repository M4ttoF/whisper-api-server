#!/bin/bash

UPDATE_ENV=false

if [[ "$1" == "--update" ]]; then
    UPDATE_ENV=true
fi

if ! command -v uv &> /dev/null; then
    echo "uv not found. Install it from https://docs.astral.sh/uv/getting-started/installation/"
    exit 1
fi

if [[ ! -d ".venv" || "$UPDATE_ENV" == true ]]; then
    echo "Creating virtual environment..."
    uv venv .venv --python 3.12

    echo "Installing dependencies..."
    if ! uv pip install -r requirements.txt; then
        echo "Failed to install dependencies."
        exit 1
    fi
fi

echo "Starting server..."
uv run python server.py --config config.json

echo "Server stopped."
