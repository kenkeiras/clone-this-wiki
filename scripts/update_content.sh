#!/bin/sh

IFS=''
UPSTREAM_URL=https://code.codigoparallevar.com/kenkeiras/clone-this-wiki

FILE_PATH="$PWD/$0"
DOC_ROOT=$(dirname $(dirname "${FILE_PATH}"))
CONTENT_ROOT="${DOC_ROOT}/content"
RESULT_ROOT="${DOC_ROOT}/result"
TEMPLATES_ROOT="${DOC_ROOT}/templates"
SCRIPTS_ROOT="${DOC_ROOT}/scripts"
STATIC_ROOT="${DOC_ROOT}/static"

RESULT_ROOT="${DOC_ROOT}/live-files"
STATIC_RESULT_ROOT="${RESULT_ROOT}/static"
CLONE_ROOT="${RESULT_ROOT}/clone-this-wiki.git"

cd "${CONTENT_ROOT}"

IFS="`printf \'\\\\n\'`"
for f in `find . -type f`;do

    fout=`echo "${RESULT_ROOT}/$f" | sed 's/\.[^.]*$//'`

    case "$f" in
        *.md)
            (
                cat "${TEMPLATES_ROOT}/header.html";
                markdown "$f";
                cat "${TEMPLATES_ROOT}/footer.html"
            ) > "$fout.html"
            ;;
        *)     continue ;;
    esac
done

if [ ! -d "${STATIC_RESULT_ROOT}" ];then
    mkdir "${STATIC_RESULT_ROOT}"
fi
cp -R "${STATIC_ROOT}/"* "${STATIC_RESULT_ROOT}/"

if [ ! -d "${CLONE_ROOT}" ];then
    git clone --bare "${UPSTREAM_URL}" "${CLONE_ROOT}"
    cd "${CLONE_ROOT}"
    git update-server-info

elif [ "$1" = "--pull" ];then
    cd "${CLONE_ROOT}"
    git fetch --all
    git update-server-info
fi
