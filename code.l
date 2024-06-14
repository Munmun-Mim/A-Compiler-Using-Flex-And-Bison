%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "20101041.tab.h"
%}

%option noyywrap

%%

"main"      { return MAIN; }
"{"         { return OPEN_BRACE; }
"}"         { return CLOSE_BRACE; }
"INTEGER"   { return INTEGER; }
"IF"        { return IF; }
"ELSE"      { return ELSE; }
"SWITCH"    { return SWITCH; }
"CASE"      { return CASE; }
"BREAK"     { return BREAK; }
"DEFAULT"   { return DEFAULT; }
"FOR"       { return FOR; }
"PRINT"     { return PRINT; }
"LOG10"     { return LOG10; }
"LOG"       { return LOG; }
"SIN"       { return SIN; }
"import"    { return IMPORT; }
[0-9]+      { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return IDENTIFIER; }
"<"         { return '<'; }
">"         { return '>'; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"="         { return '='; }
"("         { return '('; }
")"         { return ')'; }
";"         { return ';'; }
"#"         { return '#'; }
"//"(.*)    { /* Single line comment */ }
"/*"([^*]|(\*+([^*/])))*\*+"/" { /* Multi-line comment */ }
.           { /* Ignore other characters */ }
\n          { return EOL; }

%%

int yywrap() {
    return 1;
}