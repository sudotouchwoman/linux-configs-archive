#!/usr/bin/env bash

# creates a db of symbols for your project
# (ensure that you have compdb installed and in PATH)
# https://github.com/Sarcasm/compdb

BUILD=${BUILD:-build}
DEST=${DEST:-.vscode/compile_commands.json}
compdb -p $BUILD list > $DEST
