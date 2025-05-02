%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define Identifier 1
#define Operator 2
#define Keyword 3
#define Number 4
#define Dellimeter 5
#define String 6

int line_no = 1;
void yyerror(const char* msg);

int is_palindrome(const char* str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - i - 1])
            return 0;
    }
    return 1;
}
%}

%option noyywrap

%%

\n                          { line_no++; }
[\t ]+                      { }

"#include"|"int"|"char"|"float"|"double"|"printf"|"main"|"include"|"return"|"public"|"static"|"void"|"System"|"out"|"println"|"cout"|"cin"|"String"  {
                               printf("%d\t%s\tKeyword\t%d\n", line_no, yytext, Keyword);
                             }

"<<"|">>"|"+"|"-"|"*"|"/"|"%" {
                               printf("%d\t%s\tOperator\t%d\n", line_no, yytext, Operator);
                             }

[a-zA-Z_][a-zA-Z0-9_]*      {
                               printf("%d\t%s\tIdentifier\t%d", line_no, yytext, Identifier);
                               if (is_palindrome(yytext)) {
                                   printf("  --> Palindrome");
                               }
                               printf("\n");
                             }

[0-9]+                      { printf("%d\t%s\tNumber\t%d\n", line_no, yytext, Number); }

\"([^\"\n]*)\"              { printf("%d\t%s\tSTRING\t%d\n", line_no, yytext, String); }

\"[^\"\n]*                  { yyerror("Incomplete string"); }

[(){}\[\],.:;=<>]           { printf("%d\t%s\tDellimeter\t%d\n", line_no, yytext, Dellimeter); }

.                           { yyerror("Invalid token or unrecognized symbol"); }

%%

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        printf("Unable to open file\n");
        return 1;
    }

    yyin = file;
    printf("Line\tLexeme\tToken\tValue\n");
    yylex();
    fclose(file);
    return 0;
}

void yyerror(const char* msg) {
    printf("Lexical error at line %d: %s -> %s\n", line_no, msg, yytext);
    exit(1);
}
