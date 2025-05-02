%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char* msg);
int yylex();
extern FILE *yyin;
%}

%union {
    int num;
    char* id;
}

%start program

%token <id> ID
%token <num> NUMBER

%token SWITCH CASE DEFAULT BREAK COLON
%token IF ELSE RLOP LBRAC RBRAC LPAR RPAR ASSIGN SEMI PLUS

%%

program:
    
   switchstmt
  ;

switchstmt:
    SWITCH LPAR ID RPAR LBRAC caselist defaultcase RBRAC
    { printf("Switch-case syntax is correct\n"); }
  ;

caselist:
    caselist caseblock
  | caseblock
  ;

caseblock:
    CASE NUMBER COLON statements BREAK SEMI
  ;

defaultcase:
    DEFAULT COLON statements BREAK SEMI
  ;

condition:
    ID RLOP NUMBER
  ;

statements:
    statement
  | statements statement
  ;

statement:
    ID ASSIGN expr SEMI
  ;

expr:
    ID
  | ID PLUS NUMBER
  ;

%%

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        perror("Unable to open file");
        return 1;
    }

    yyin = file;
    yyparse();
    fclose(file);
    return 0;
}

void yyerror(const char* msg) {
    printf("Syntax error: %s\n", msg);
    exit(1);
}
