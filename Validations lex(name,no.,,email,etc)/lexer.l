%{
#include <stdio.h>
#include <string.h>
%}

%%

[0-9]{10}                                   { printf("%-15s %-30s\n", "Phone No:", yytext); }
[a-zA-Z0-9_.]+@[a-zA-Z]+\.[a-zA-Z]+         { printf("%-15s %-30s\n", "Email Id:", yytext); }
https:\/\/www\.[a-z]+\.[a-z]+               { printf("%-15s %-30s\n", "URL:", yytext); }
[0-9]{2}-[0-9]{2}-[0-9]{4}                  { printf("%-15s %-30s\n", "Date:", yytext); }
[0-9]{2}:[0-9]{2}[ ](AM|PM)                 { printf("%-15s %-30s\n", "Time:", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*                      { printf("%-15s %-30s\n", "Valid Name:", yytext); }
[ \t\n]+                                    { /* Skip whitespace */ }
.                                           { printf("%-15s %-30s\n", "Unknown:", yytext); }

%%

int main() {
    FILE *file;
    file = fopen("input.txt", "r");
    if (!file) {
        printf("Input File Not Found\n");
        return 1;
    }
    printf("%-15s %-30s\n", "Type", "Lexeme");
    yyin = file;
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}