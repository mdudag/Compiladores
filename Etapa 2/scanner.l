%{
#include "parser.tab.h"
%}

%%
[ \t\n\r]                     {/* ignora espaços e quebras de linha e tabs */}
"leitura"                      return LEITURA;
"escrita"                      return ESCRITA
"float"                        return FLOAT;
[a-zA-Z][a-zA-Z0-9]{0,9}       return ID;
[0-9]+                         return NUM;
"+"                            return '+';
"-"                            return '-';
"*"                            return '*';
"/"                            return '/';
"("                            return '(';
")"                            return ')';
"{"                            return '{';
"}"                            return '}';
";"                            return PV;
.                              {/* ignora caracteres inválidos */}
%%
