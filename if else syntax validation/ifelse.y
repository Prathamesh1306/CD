%{

#include<stdio.h>
#include <stdlib.h>
void yyerror(const char* msg);
int yylex();

extern FILE *yyin;
%}

%union{
    int num;
    char* id;
}

%start program

%token <id> ID
%token <num> NUMBER
%token IF ELSE RLOP LBRAC RBRAC LPAR RPAR ASSIGN SEMI PLUS


%%

program: 
  ifelse
  ;

ifelse:
 IF LPAR condition RPAR LBRAC statements RBRAC ELSE LBRAC statements RBRAC
 {printf("If else syntax is correct");}
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