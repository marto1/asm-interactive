#!/bin/bash
set -e
PROG=hello
INJECT=inject

if [ "$1" == "clean" ]; then
    rm *.o *.l $PROG $INJECT
    exit 0
fi

nasm -f bin -o $INJECT -l $INJECT.l $INJECT.asm
nasm -f elf64 -o $PROG.o -l $PROG.l $PROG.asm
ld -o $PROG $PROG.o -lc -I /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
gdb -x cmdfile $PROG


