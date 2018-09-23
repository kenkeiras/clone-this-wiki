# Mix pre
s/<\/code><\/pre><pre><code>/\n/g;

# Mix ul
s/<\/ul><ul>/\n/g;

# Change <br> into <p>
s/^/<p>/g;
s/$/<\/p>/g;
s/<br\/>/<\/p><p>/g;