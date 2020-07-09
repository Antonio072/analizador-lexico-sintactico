%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>
%}

%union {int num; char id;}         /* Yacc definitions */
%start line
%token print
%token type
%token <num> number
%token <id> identifier
%token IF ELSE WHILE COMILLAS menorIgual mayorIgual igual diferente AND OR TRUE FALSE
%token aumento decremento

%type <num> line exp term condicional
%type <id> assignment 

%%

/* descriptions of expected inputs     corresponding actions (in C) */

line    :declaracion ';'{;}
    | WHILE '(' expr ')' stmt  {printf("Estructura de control while valida\n");}
    | assignment ';'		{;}
		| print  identifier  ';'			{printf("Printing \n");}
    | condicional 
    | print '(' exp ')' ';' {printf("Impresion valida \n");}

    /* This allows recursion and multiple instructions */
    | line WHILE '(' expr ')' stmt {printf("While\n");}
    | line declaracion ';'{;}
    | line condicional  {;}
    | line assignment ';'	
		| line print '(' exp ')' ';'	 {printf("Impresion valida \n");}
    ;

declaracion :type identifier ',' {;} 
            | type identifier          {printf("Declaracion de variable valida\n");}
            | type identifier '=' exp  {printf("Declaracion y asignacion de variable valida\n");}
            | type identifier '=' COMILLAS exp COMILLAS  {printf("Declaracion y asignacion de variable valida\n");}
            | declaracion identifier   {printf("\rDeclaracion de varias variables\n");}
            ; 

condicional : 
              IF '(' expr ')' stmt {;}
            | IF '(' expr ')' stmt ELSE stmt  {printf("Estructura if/else valida\n");}
            ;

stmt : declaracion ';' {printf("Estructura if valida\n");}
      | assignment ';' {printf("Estructura if valida\n");}
      | '{' line '}' 
      ;

assignment : identifier '=' exp           { printf("Asignacion de valor a variable\n"); } 
            | identifier '=' COMILLAS identifier COMILLAS {printf("String valida\n");}
            | identifier aumento          { printf("Incremento valido\n\n");} 
            | identifier decremento       { printf("Decremento valido\n\n");} 
            | aumento identifier          { printf("Incremento valido\n\n");} 
            | decremento identifier       { printf("Decremento valido\n\n");} 
           ; 
           
exp    	: term                  {;}
        | exp term
        ;

term   	: number                {;}
		    | identifier			{;} 
        ;

expr 	:expr relop expr
 	| 	expr logical_op expr
 	| 	'(' expr ')'
   | exp
   | TRUE
   | FALSE
   ;

relop 	: 	igual
          |	diferente
          |	menorIgual
          |	'<'
          |	mayorIgual
          |	'>'

logical_op 	: 	AND
            |	OR
            ;
%%                     /* C code */

int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {printf ("Instruccion invalida para el lenguaje\n");} 