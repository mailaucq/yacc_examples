%{
#include <stdlib.h>
#include "y.tab.h"
%}

%%
"while"         {return(WHILE);}
"if"            {return(IF);}
"else"          {return(ELSE);}
"int"           {return type;} 
"String"        {return type;}
"print"         {return print;}
"TRUE"          {return(TRUE);}
"FALSE"         {return(FALSE);}
\"              {return(COMILLAS);}
","             {;}
"&&"            {return(AND);}
"||"            {return(OR);}
"<="            {return(LESS_EQUAL);}
">="            {return(GREATER_EQUAL);}
"=="            {return(EQUAL);}
"!="            {return(DIFFERENT);}
"<"             {return('<');}
">"             {return('>');}
"("             {return('(');}
")"             {return(')');}
"{"             {return('{');}
"}"             {return('}');}
[0-9]+          {return number;}
[A-Za-z0-9_]+   {return IDENTIFIER;}
"++"            {return INCREMENT;}
"--"            {return DECREMENT;}
[=;]            {return yytext[0];}
[ \t\n] 	 {}
.               {fprintf(stderr, "Unknow character %s\n", yytext);}       
%%


