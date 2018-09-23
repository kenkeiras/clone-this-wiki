# Introduction

This is a offline-first wiki mean for minimal dependencies, just download it and edit the files on the `content` folder. Downloading the files can be done using `git` by doing

    git clone https://wiki.codigoparallevar.com/clone-this-wiki.git

The format supported at this point is [Markdown](https://daringfireball.net/projects/markdown/basics). It is recommended to get a real Markdown parser program (the building script will try to run `markdown`). If you can't get one, in the `scripts/markdown` folder there's a quick-n-dirty script that can *sort-of* work for simple files (keep in mind that it does not support *underlined headers*).

To convert the files into .html ones readable from a browser just run the `scripts/update_content.sh` file, and contents will be available on the `live-files` directory.

    cd clone-this-wiki
    sh scripts/update_content.sh

This files should be browsable directly from the filesystem or hosted on a remote web server.