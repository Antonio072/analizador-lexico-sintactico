L			[a-zA-Z_]
%{
#include "y.tab.h"
void yyerror (char *s);
int yylex();
%}
%%
"while"                     {return(WHILE);}
"if"                        {return(IF);}
"else"                      {return(ELSE);}
"int"                       {return type;}
"String"                    {return type;}
"printf"				    {return print;}
"TRUE"                      {return(TRUE);}
"FALSE"                      {return(FALSE);}
\"                          {return(COMILLAS);}
","                         {;}
"&&"			            {return(AND); }
"||"			            {return(OR); }
"<="			            {return(menorIgual); }
">="			            {return(mayorIgual); }
"=="			            {return(igual); }
"!="			            {return(diferente); }
"<"                         {return('<');}
">"                         {return('>');}
"("                         {return('(');}
")"                         {return(')');}
"{"                         {return('{');}
"}"                         {return('}');} 
[0-9]+                      { return number;}
[A-Za-z0-9_]+			   {return identifier;}
"++"                    {return aumento;}
"--"                    {return decremento;}
[=;]           	   {return yytext[0];}
[ \t\n]                ;
.                      {ECHO; yyerror ("Error:Caracter no valido");}

%%
int yywrap (void) {return 1;}
