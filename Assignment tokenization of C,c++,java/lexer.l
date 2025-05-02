%{

#include<stdio.h>
#include<stdlib.h>

#define Identifier 1
#define Operator 2
#define Keyword 3
#define Number 4
#define Dellimeter 5
#define String 6

int line_no=1;
void yyerror(const char* msg);
%}

%option noyywrap

%%

\n  {line_no++;}
[\t ]+ {}



"#include"|"int"|"char"|"float"|"double"|"printf"|"main"|"include"|"return"|"public"|"static"|"void"|"System"|"out"|"println"|"cout"|"cin"|"String"  { printf("%d\t%s\tKeyword\t%d\n",line_no,yytext,Keyword);}

"<<"|">>"|"+"|"-"|"*"|"/"|"%" { printf("%d\t%s\tOperator\t%d\n",line_no,yytext,Operator);}


[a-zA-Z_][a-zA-Z0-9_]* { printf("%d\t%s\tIdenitifier\t%d\n",line_no,yytext,Identifier);}
[0-9]+ { printf("%d\t%s\tNumber\t%d\n",line_no,yytext,Number);}


\"([^\"\n]*)\" { printf("%d\t%s\tSTRING\t%d\n",line_no,yytext,String);}

\"[^\"\n]* {yyerror("Incomplete string");}

[(){}\[\],.:;=<>] { printf("%d\t%s\tDellimeter\t%d\n",line_no,yytext,Dellimeter);}

. {yyerror("Invalid token or unrecognized symbol");}

%%

int main(int argc,char* argv[]){
  
  if(argc<2){
    printf("used by:<input_file>\n",argv[0]);
  }
  
  FILE* file=fopen(argv[1],"r");
  if(!file){
    printf("Unable to open file");
    return 1;
  }

  yyin=file;
  printf("Line\tLexeme\ttoken\tvalue\n");
  yylex();
  fclose(file);
  return 0;


}

void yyerror(const char* msg){
    printf("Lexcial error at %d : %s -> %s\n",line_no,msg,yytext);
    exit(1);
}