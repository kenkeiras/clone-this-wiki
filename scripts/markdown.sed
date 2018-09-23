#!/bin/sed -f

# Headers
s/^###### \(.*\)/<h6>\1<\/h6>/g;
s/^##### \(.*\)/<h5>\1<\/h5>/g;
s/^#### \(.*\)/<h4>\1<\/h4>/g;
s/^### \(.*\)/<h3>\1<\/h3>/g;
s/^## \(.*\)/<h2>\1<\/h2>/g;
s/^# \(.*\)/<h1>\1<\/h1>/g;

# Links
s/\[\(.*\)\](\(.*\))/<a href="\2">\1<\/a>/g ;

# <pre> blocks
s/^    \(.*\)/<pre><code>\1<\/code><\/pre>/;

# <code> annotations
s/`\([^`]*\)`/<code>\1<\/code>/g;

# Line jumps
s/^[[:space:]]*$/<br\/>/;

# bold and italics
s/\*\*\([^*]*\)\*\*/ <strong>\1<\/strong>/g;
s/\*\([^*]*\)\*/ <em>\1<\/em>/g;

# List 
s/^\* \(.*\)/<ul><li>\1<\/li><\/ul>/g;