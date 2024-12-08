%{
   #include "parser.tab.h"
%}

ID [a-zA-Z][a-zA-Z0-9]{0,9}
TIPO_FLOAT ([+-]?([1-9][0-9]*[.][0-9][0-9]?|[0][.]([1-9][0-9]?|[0-9][1-9]))|[0][.][0][0]?)

%%

"PROGRAMA"    {return PROGRAMA;}
"PREX"        {return PREX;}
"FLOAT"       {return FLOAT;}
"ESCREVER"    {return ESCREVER;}
"LER"         {return LER;}
{ID}          {yylval.s = strdup(yytext); return ID;}
{TIPO_FLOAT}  {yylval.f = atof(yytext); return TIPO_FLOAT;}
"="           {return '=';}
"+"           {return '+';}
"-"           {return '-';}
"*"           {return '*';}
"/"           {return '/';}
"{"           {return '{';}
"}"           {return '}';}
";"           {return PV;}
","           {return ',';}
[\t]+         {/* Ignora espaços em branco */}
.             {/* Ignora símbolos inválidos */}

%%
