%{

#include "While.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern YYSTYPE yylval;
%}

%option noyywrap
%%

"while" {return WHILE;}
"do" {return DO;}
"(" {return LPAR;}     
")" {return RPAR;}
"{" {return LBRAC;}
"}" {return RBRAC;}
"+" {return PLUS;}
"=" {return ASSIGN;}
";" {return SEMI;}

"<="|">="|"<"|">"|"=="|"!=" {return RLOP;}

[0-9]+ {yylval.num=atoi(yytext); return NUMBER;}
[a-zA-Z_][a-zA-Z0-9_]* {yylval.id=strdup(yytext); return ID;}
[ \t\n]+ { }
. {printf("Unrecognized token : %s",yytext);}

%%