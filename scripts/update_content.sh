#!/bin/sh

IFS=''

FILE_PATH="$PWD/$0"
DOC_ROOT=$(dirname $(dirname "${FILE_PATH}"))
CONTENT_ROOT="${DOC_ROOT}/content"
RESULT_ROOT="${DOC_ROOT}/result"
TEMPLATES_ROOT="${DOC_ROOT}/templates"
SCRIPTS_ROOT="${DOC_ROOT}/scripts"

cd "${CONTENT_ROOT}"

IFS="`printf \'\\\\n\'`"
for f in `find . -type f`;do

    fout=`echo "$f" | sed 's/\.[^.]*$//'`

    case $f in
        *.md)
            (
                cat "${TEMPLATES_ROOT}/header.html";
                markdown "$f";
                cat "${TEMPLATES_ROOT}/footer.html"
            ) > ../"$fout.html"
            ;;
        *)     continue ;;
    esac


done
