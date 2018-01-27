#!/bin/bash
set -e
PROG=hello

if [ "$1" == "clean" ]; then
    rm $PROG.o $PROG.l $PROG
    exit 0
fi


nasm -f elf64 -o $PROG.o -l $PROG.l $PROG.asm
ld -o $PROG $PROG.o
gdb -x cmdfile $PROG


