%{
#include <stdio.h>
#include <string.h>
#include <math.h>
extern FILE* yyin;
extern int yylineno;
int yylex();
void yyerror(const char* s);
%}

%token MAIN OPEN_BRACE CLOSE_BRACE INTEGER IF ELSE SWITCH CASE BREAK DEFAULT FOR PRINT LOG10 LOG SIN IMPORT NUM IDENTIFIER EOL

%%

program:
    statements
    ;

statements:
    statement EOL
    | statements statement EOL
    ;

statement:
    declaration_statement
    | assignment_statement
    | if_statement
    | switch_statement
    | loop_statement
    | print_statement
    | log10_statement
    | log_statement
    | sin_statement
    | import_statement
    ;

declaration_statement:
    INTEGER IDENTIFIER { printf("Declaration\n"); printf("Value of the variable: %s\t\n", $2); }
    ;

assignment_statement:
    IDENTIFIER '=' NUM { printf("Value of the variable: %s\t\n", $1); printf("Value of the variable: %d\t\n", $3); }
    | IDENTIFIER '=' IDENTIFIER { printf("Value of the variable: %s\t\n", $1); printf("Value of the variable: %s\t\n", $3); }
    ;

if_statement:
    IF '(' IDENTIFIER '>' IDENTIFIER ')' OPEN_BRACE IDENTIFIER '+' IDENTIFIER ';' CLOSE_BRACE ELSE OPEN_BRACE IDENTIFIER '-' IDENTIFIER ';' CLOSE_BRACE
    ;

switch_statement:
    SWITCH '(' IDENTIFIER ')' '{' CASE NUM ':' IDENTIFIER '+' IDENTIFIER ';' BREAK '+' CASE NUM ':' IDENTIFIER '+' IDENTIFIER ';' BREAK '+' CASE NUM ':' IDENTIFIER '+' IDENTIFIER ';' BREAK '+' DEFAULT ':' IDENTIFIER '+' IDENTIFIER ';' BREAK '}'
    ;

loop_statement:
    FOR '(' NUM '<' NUM ')' '{' IDENTIFIER '=' IDENTIFIER '+' IDENTIFIER ';' '}'
    ;

print_statement:
    PRINT '(' IDENTIFIER ')' { printf("Print Expression %s\n", $2); }
    ;

log10_statement:
    LOG10 '(' NUM ')' ';' { printf("Value of Log10(%d) is %f\n", $3, log10($3)); }
    ;

log_statement:
    LOG '(' NUM ')' ';' { printf("Value of Log(%d) is %f\n", $3, log($3)); }
    ;

sin_statement:
    SIN '(' NUM ')' ';' { printf("Value of Sin(%d) is %f\n", $3, sin($3)); }
    ;

import_statement:
    IMPORT IDENTIFIER { printf("Import statement: %s\n", $2); }
    ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }
    FILE* f = fopen(argv[1], "r");
    if (!f) {
        perror(argv[1]);
        return 1;
    }
    yyin = f;
    yyparse();
    fclose(f);
    return 0;
}
