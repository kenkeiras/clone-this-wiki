#!/bin/sh

DIR="$(dirname "$0")"

sed -f "$DIR/markdown.sed" | tr -d '\n' | sed -f "$DIR/markdown2.sed" | sed -f "$DIR/markdown3.sed"