%{
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char* msg);
int yylex();
extern FILE *yyin;
%}

%union{
    int num;
    char* id;
}


%token <num> NUMBER
%token <id> ID

%start program

%token WHILE DO LPAR RBRAC RPAR LBRAC PLUS ASSIGN RLOP SEMI

%%

program:
   WHILE_LOOP 
   | DO_while
   ;


WHILE_LOOP:
   WHILE LPAR condition RPAR LBRAC statements RBRAC  
   {printf("Valid while loop")}
   ;

DO_while:
   DO LBRAC statements RBRAC WHILE LPAR condition RPAR SEMI
   {printf("Valid DO-while loop");}
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

int main(int argc,char* argv[]){
    if(argc<2){
        printf("Usage: <input_file>",argv[0]);
        return 1;
    }

    FILE* file=fopen(argv[1],"r");
    if(!file){
        printf("Unable to open file:");
        return 1;
    }
    
    yyin=file;
    yyparse();
    fclose(file);

    return 0;
}


void yyerror(const char* msg){
    printf("Invalid loop: %s",msg);
    exit(1);
}