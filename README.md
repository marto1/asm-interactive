Description
===========

GDB interactive opcode injection. 

Goal is to make an interactive assembly "interpreter" relying on gdb.
The gdb dashboard gives a nice overview of register/flag changes etc.
so it makes it suitable for learning machine instructions.



Install
=======

* gdb
* nasm
* https://github.com/cyrus-and/gdb-dashboard

Demo
====

[![demo](https://asciinema.org/a/B33dCtFc9QvRxIY8Lfxkzl9eR.png)](https://asciinema.org/a/B33dCtFc9QvRxIY8Lfxkzl9eR?autoplay=1)


TODOS


* TODO Detailed installation instructions 
* TODO Multiline command
* TODO Inject without inject file
* TODO Port to other architectures
* TODO Self contained(no nasm and/or gdb)
