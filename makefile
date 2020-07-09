
yacc program.y
lex program.lex
gcc lex.yy.c y.tab.c -o program
./program
