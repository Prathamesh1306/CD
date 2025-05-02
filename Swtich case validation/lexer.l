%{
#include "switchcase.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern YYSTYPE yylval;
%}

%option noyywrap

%%

"if"            { return IF; }
"else"          { return ELSE; }
"switch"        { return SWITCH; }
"case"          { return CASE; }
"default"       { return DEFAULT; }
"break"         { return BREAK; }

"("             { return LPAR; }
")"             { return RPAR; }
"{"             { return LBRAC; }
"}"             { return RBRAC; }
";"             { return SEMI; }
"="             { return ASSIGN; }
"+"             { return PLUS; }
":"             { return COLON; }

"<="|">="|"<"|">"|"=="|"!="    { return RLOP; }

[0-9]+          { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.id = strdup(yytext); return ID; }

[ \t\n]+        { /* skip whitespace */ }

.               { printf("Lexical error: Unrecognized token '%s'\n", yytext); }

%% 
