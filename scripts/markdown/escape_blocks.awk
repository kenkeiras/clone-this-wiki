{
    if ($0 ~ /^    /) {
        gsub("&", "\\&amp;", $0);
        gsub("<", "\\&lt;", $0);
        gsub(">", "\\&gt;", $0);
        print $0
    }
    else {
        gsub("<code>", "\n<code>", $0)
        gsub("</code>", "</code>\n", $0)
        print $0
    }
}