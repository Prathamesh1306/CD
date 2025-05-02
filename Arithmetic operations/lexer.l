%{
#include "yacc.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+ {
    yylval = atoi(yytext);
    return NUMBER;
}

[\t ]   ;             // Ignore tabs/spaces
\n      return 0;
.       return yytext[0];

%%

int yywrap() {
    return 1;
}
