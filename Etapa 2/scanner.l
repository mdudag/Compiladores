%{
#include"parser.tab.h"
}%

%%
[\t]+                        {/* ignora espaços em branco e quebras de linha */}
[a-zA-Z][a-zA-Z0-9]{0,9}     {return ID;}
"escrita"                    {return ESCRITA;}
"leitura"                    {return LEITURA;}
"float"                      {return FLOAT;}
"+"                          {return '+';}
"-"                          {return '-';}
"*"                          {return '*';}
"/"                          {return '/';}
"("                          {return '(';}
")"                          {return ')';}  
"{"                          {return '{';}
"}"                          {return '}';}
[0-9]+                       {return INT;}
";"                          {return PV;}
.                            {/* ignora símbolos inválidos */}
%%
