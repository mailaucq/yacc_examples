yacc: lex.yy.c y.tab.c
	gcc -o ex1 lex.yy.c y.tab.c -lfl

lex.yy.c:
	lex ex1.l

y.tab.c:
	yacc -d ex1.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h ex1

