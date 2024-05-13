#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# Set exit on error
set -e

# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if jq is installed
if ! command_exists jq; then
    echo "Error: 'jq' is not installed. Please install jq (https://stedolan.github.io/jq/) and try again."
    exit 1
fi

cd package

# Check if metadata.json exists
if [ ! -f "metadata.json" ]; then
    echo "Error: 'metadata.json' not found"
    exit 1
fi

# Extract the version number from metadata.json using jq
version=$(jq -r '.KPlugin.Version' metadata.json)

# Check if version is empty (indicating extraction failure)
if [ -z "$version" ]; then
    echo "Error: Failed to extract version from metadata.json"
    exit 1
fi

# Create the ZIP file using the extracted version number
zip -R "../audio-device-switcher-v$version.plasmoid" '*.qml' 'metadata.json' '*.xml'

cd ..
