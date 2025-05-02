%{

#include <stdio.h>
#include <stdlib.h>

#define keyword 1
#define String 2
#define number 3
#define Delimeter 4
#define Identifier 5

int line_no=1;
void yyerror(const char* msg);
%}

%option noyywrap

%%

\n {line_no++;}
[\t ]+ { }

"SELECT"|"FROM"|"WHERE"|"INSERT"|"INTO"|"VALUES"|"UPDATE"|"SET"|"DELETE"|"CREATE"|"TABLE"|"DATABASE"|"DROP"|"ALTER"  {printf("%d\t%s\tKeyword\t%d\n",line_no,yytext,keyword);}

\"([^\"\n]*)\" {printf("%d\t%s\tString\t%d\n",line_no,yytext,String);}

[0-9]+ {printf("%d\t%s\tnumber\t%d\n",line_no,yytext,number);}

[(){},;=.*]  {printf("%d\t%s\tDelimeter\t%d\n",line_no,yytext,Delimeter);}

[a-zA-Z_][a-zA-Z0-9]*  {printf("%d\t%s\tIdentifier\t%d\n",line_no,yytext,Identifier);}

\"[^\"\n]* {yyerror("Incomplete sentence:");}

. {yyerror("Unrecognized token");}

%%

int main(int argc,char* argv[]){
  if(argc<2){
    printf("Usage: <input_file>",argv[0]);
  }

  FILE* file=fopen(argv[1],"r");
  if(!file){
    printf("Unable to open file ");
    return 1;
  }

  yyin=file;
  printf("Line\tLexeme\ttoken\tvalue\n");
  yylex();
  fclose(file);
  return 0;
}

void yyerror(const char* msg){
    printf("Error at %d: %s->%s",line_no,msg,yytext);
    exit(1);
}