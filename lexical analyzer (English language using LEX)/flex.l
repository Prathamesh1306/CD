%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define yywrap to prevent linking errors
int yywrap(void) {
    return 1;
}

int line_no = 1; // To track line numbers
%}

/* Token Definitions */
WHITESPACE [ \t]+
NEWLINE \n
PUNCT [.,:;!?(){}[\]=\+\-\*/<>@#$%^&|~`]
QUOTE ["']
NUMBER [0-9]+
ADJ ([a-zA-Z]+(able|al|ful|ic|ive|less|ous))
ADV ([a-zA-Z]+(ly))
VERB ([a-zA-Z]+(ed|ing|s))
NOUN (Arthur|kingdom|villager|dragon|knight|[a-zA-Z]+(tion|ment|ness|ity|ship|hood))
WORD [a-zA-Z]+
SPECIAL [^\x00-\x7F]
UNHANDLED .

%%
{WHITESPACE} { /* Ignore whitespace */ }
{NEWLINE} { line_no++; }
{PUNCT} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "PUNCTUATION", yytext); }
{QUOTE} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "QUOTATION", yytext); }
{NUMBER} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "NUMBER", yytext); }
{ADJ} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "ADJECTIVE", yytext); }
{ADV} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "ADVERB", yytext); }
{VERB} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "VERB", yytext); }
{NOUN} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "NOUN", yytext); }
{WORD} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "WORD", yytext); }
{SPECIAL} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "SPECIAL CHARACTER", yytext); }
{UNHANDLED} { printf("| %-8d | %-15s | %-15s | %-20s |\n", line_no, yytext, "UNHANDLED", yytext); }
%%

int main(int argc, char *argv[]) {
    FILE *file;
    char default_file[] = "aot.txt"; // Default file name
    
    // Check if a file is provided as a command-line argument
    if (argc < 2) {
        printf("No input file provided. Using default file '%s'.\n", default_file);
        // Check if the default file exists
        file = fopen(default_file, "r");
        if (!file) {
            printf("Error: Default file '%s' not found in the current directory.\n", default_file);
            return 1;
        }
    } else {
        file = fopen(argv[1], "r");
        if (!file) {
            printf("Error: Unable to open file '%s'.\n", argv[1]);
            return 1;
        }
    }
    
    yyin = file;
    
    // Print table header
    printf("+----------+----------------+----------------+----------------------+\n");
    printf("| Line No. | Lexeme         | Token          | Token Value          |\n");
    printf("+----------+----------------+----------------+----------------------+\n");
    
    // Start lexical analysis
    yylex();
    
    printf("+----------+----------------+----------------+----------------------+\n");
    fclose(file);
    return 0;
}