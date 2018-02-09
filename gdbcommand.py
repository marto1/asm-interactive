import os

asm_template = """
BITS 64
injectit:
	{0}
	TIMES 8 nop 		; keep this

"""
INJECT_FILE = "inject" #filename without extension

class inject(gdb.Command):

    def invoke(self, args, from_tty):
        code = asm_template.format(args)
        with open("{0}.asm".format(INJECT_FILE), "w") as f:
            f.write(code)
        cmd = "nasm -f bin -o {0} -l {0}.l {0}.asm"
        os.system(cmd.format(INJECT_FILE))
        gdb.execute('jump _start')

inject("inject", gdb.COMMAND_USER)
