%{
#include <stdlib.h>
#include <stdio.h>

extern int yylex();
void yyerror(char *s);

%}

%token BOOLEAN
%token AND
%token OR
%token NOT

%left OR
%left AND

%%
prog: prog S
        |
	;

S:      E   ';'        { printf("Expr value is %d\n", $1); }
        ;

E:      E AND T     {$$ = $1 && $3;}
	| E OR T    {$$ = $1 || $3;}  
	| T         { $$ = $1;}
        ;

T:	'(' E ')'   { $$ = $2;} 
	| NOT T     {$$ = ($2 == 0);}
	| BOOLEAN   { $$ = $1;}
	;
	
%%

void yyerror(char *msg){
	fprintf(stderr, "%s\n", msg);
	exit(1);
}

int main() {
	yyparse();
	return 0;
}
