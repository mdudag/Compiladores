%{

#include"parser.tab.h"

%}

%%

[\t]+                   {; /* ignora espaços em branco*/}
"leitura"               {return LEITURA;}
"escrita"               {return ESCRITA;}
"float"                 {return FLOAT;}
[0-9]+                  {yyval.fval = atof(yytext); return NUMERO;}
[a-zA-Z] [a-zA-Z0-9]*   {yyval.sval = strdup(yytext); return ID;}
.                       {/* ignora símbolos inválidos */}

%%