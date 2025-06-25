NASM	=	nasm
LD	=	ld
BIN	=	TUFFshell
MV	=	mv

TUFFshell:
	$(NASM) -f elf64 src/exit.asm
	$(NASM) -f elf64 src/main.asm
	$(NASM) -f elf64 src/child.asm
	$(LD) src/*.o -o $(BIN)
	$(MV) src/*.o obj/

clean:
	rm -f obj/*.o

fclean:	clean
	rm -f shell

re:	fclean all

.PHONY:	TUFFshell re clean fclean
