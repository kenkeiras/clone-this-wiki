# Clean <p>
s/<p><pre>/<pre>/g;
s/<p><h/<h/g;
s/<\/pre><\/p>/<\/pre>/g;
s/<\/\(h[[:digit:]]\)><\/p>/<\/\1>/g;
