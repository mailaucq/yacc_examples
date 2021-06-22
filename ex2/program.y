%{
#include <stdlib.h>
#include <stdio.h>

extern int yylex();
void yyerror (char *s);

%}

%union {int num; char id;}
%start prog
%token print
%token type
%token IF ELSE WHILE COMILLAS LESS_EQUAL GREATER_EQUAL EQUAL DIFFERENT AND OR TRUE FALSE
%token INCREMENT DECREMENT

%token <num> number
%token <id> IDENTIFIER

%type <num> line VARIABLE TERM CONDITIONAL
%type <id> ASSIGNMENT

%%

prog: prog line
        |
	;
	
line:     DECLARATION ';'  						{;}
	| WHILE '(' EXPRESSION ')' stmt 				{printf("Valid while\n");}
	| ASSIGNMENT ';'                 				{;}
	| CONDITIONAL
	| print '(' VARIABLE ')' ';' 					{printf("Valid print\n");}
	/*allowing recursion*/
	| line WHILE '(' EXPRESSION ')' stmt 				{printf("Valid while\n");} 
	| line DECLARATION ';'  					{;}
	| line CONDITIONAL      					{;}
	| line ASSIGNMENT ';'						{;}
	| line print '(' VARIABLE ')' ';' 				{printf("Valid print\n");}
	;

DECLARATION :type IDENTIFIER ',' 					{;}
		|type IDENTIFIER  					{printf("Declaracion de variable valida\n");}
		|type IDENTIFIER  '=' VARIABLE 			{printf("Declaracion y asignacion de variable valida\n");}
		|type IDENTIFIER  '=' COMILLAS VARIABLE COMILLAS	{printf("Declaracion y asignacion de variable\n");}
		|DECLARATION IDENTIFIER		          	{printf("Declaracion de varias variables\n");}
		;

ASSIGNMENT  :IDENTIFIER '=' VARIABLE					{printf("Asignacion de valor a variable\n");}		
		|IDENTIFIER '=' COMILLAS IDENTIFIER COMILLAS		{printf("Asignacion de valor a variable\n");}
		|IDENTIFIER INCREMENT					{printf("Incremento valido\n");}
		|IDENTIFIER DECREMENT					{printf("Decremento valido\n");}
		|INCREMENT IDENTIFIER					{printf("Incremento valido\n");}
		|DECREMENT IDENTIFIER					{printf("Decremento valido\n");}
		;

CONDITIONAL:
		IF '(' EXPRESSION ')' stmt 				{;}
		|IF '(' EXPRESSION ')' stmt ELSE stmt 		{printf("Estructura if/else valida\n");}
		;

stmt: DECLARATION ';'
	|ASSIGNMENT ';'
	|'{'line'}'
	;

VARIABLE: TERM								{;}
	|VARIABLE TERM
	;

TERM : number 								{;}
	|IDENTIFIER							{;}
	;
	
EXPRESSION: EXPRESSION RELATIONAL_OP EXPRESSION
		|EXPRESSION LOGICAL_OP EXPRESSION
		|'('EXPRESSION')'
		|VARIABLE
		|TRUE
		|FALSE
		;
RELATIONAL_OP : EQUAL
		|DIFFERENT
		|LESS_EQUAL
		|GREATER_EQUAL
		| '>'
		| '<'
		;


LOGICAL_OP: AND
	| OR
	;
%%

int main (void) {
	return yyparse();
}

void yyerror (char *s) {printf("Invalid instruction\n");}

