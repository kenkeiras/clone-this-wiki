# Introduction

This is a offline-first wiki meant to have minimal dependencies. Just download it and edit the files on the `content` folder. Downloading the files can be done using `git` by doing

    git clone https://wiki.codigoparallevar.com/clone-this-wiki.git

The format supported at this point is [Markdown](https://daringfireball.net/projects/markdown/basics). It is recommended to get a real Markdown parser program.
The building script will pick the parser from the `$MARKDOWN` environment variable. If there's none it'll try with the `markdown` command, if that also doesn't work it'll the script on `scripts/markdown`. It's a quick-n-dirty script that can **sort-of** work for simple files (keep in mind that it does not support *underlined headers*).

To convert the files into .html ones readable from a browser just run the `scripts/update_content.sh` file, and contents will be available on the `live-files` directory.

    cd clone-this-wiki
    sh scripts/update_content.sh

This files should be browsable directly from the filesystem or hosted on a remote web server.

# License

Any original content can be considered under [WTFPL](http://www.wtfpl.net/) licence (copied below), any non-original content belongs to its author:

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004
    
    Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
    
    Everyone is permitted to copy and distribute verbatim or modified
    copies of this license document, and changing it is allowed as long
    as the name is changed.
    
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
    
    0. You just DO WHAT THE FUCK YOU WANT TO.