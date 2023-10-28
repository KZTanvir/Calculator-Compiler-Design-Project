%{
#include <stdio.h>
#include <stdlib.h>
int result = 0;
int current_number = 0;
char current_operator = '+';
char *c_exp_name = "ADDITION";
%}

%option noyywrap

%%
"0/0" {
    //error handling for calculator
    printf("Error: Divided by zero!\n");
    result = 0;
    current_operator = '+';
}
[0-9]+  {
    current_number = atoi(yytext);
    switch (current_operator) {
        case '+':
            result += current_number;
            break;
        case '-':
            result -= current_number;
            break;
        case '*':
            result *= current_number;
            break;
        case '/':
            if (current_number == 0) {
                printf("Error: Divided by zero!\n");
                }
            result /= current_number;
            break;
        case '%':
            result %= current_number;
            break;
    }
}
[ \t]   { /* ignore whitespace */ }
"-"     { current_operator = '-'; c_exp_name = "SUBTRACTION";}
"+"     { current_operator = '+'; c_exp_name = "ADDITION";}
"*"     { current_operator = '*'; c_exp_name = "MULTIPLICATION";}
"/"     { current_operator = '/'; c_exp_name = "DIVISION";}
"%"     { current_operator = '%'; c_exp_name = "MODULO";}
"exit"  { exit(0); }
"reset" { result = 0; current_operator = '+'; printf("Reset successfully!\n");}
[\n]    { printf("Result(%s): %d\n", c_exp_name, result); result = 0; current_operator = '+';}
.       { /* ignore other characters */ }
%%

int main() {
    printf("************************************\n");
    printf("===========Math Calculator==========\n");
    printf("************************************\n");
    printf("Supported operations: +, -, *, /, %%, reset, exit\n");
    printf("Enter your expression:\n");
    yylex();
    return 0;
}
