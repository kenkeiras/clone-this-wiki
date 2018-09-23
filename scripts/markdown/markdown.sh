#!/bin/sh

DIR="$(dirname "$0")"

awk -f "$DIR/escape_blocks.awk" | sed -f "$DIR/markdown.sed" | tr -d '\n' | sed -f "$DIR/markdown2.sed" | sed -f "$DIR/markdown3.sed"