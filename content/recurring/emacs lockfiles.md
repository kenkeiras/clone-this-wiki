# Emacs creates .#blah files

This are meant to be [a protection against simultaneous editing](https://www.gnu.org/software/emacs/manual/html_node/emacs/Interlocking.html).
Can be disabled with the following line on the user init scripts:

    (setq create-lockfiles nil)
