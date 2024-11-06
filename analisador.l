%{
   #include <stdio.h>
%}

PALAVRA_RESERVADA (FLOAT|CHAR|LISTA|BOOL|CONST|ESCREVER|LER|SE|ENTAO|SENAO|ENQUANTO|FAÇA|PROGRAMA|PREX)
OPR_ATRIB [=]
ID [a-zA-Z]|[a-zA-Z][a-zA-Z0-9]|[a-zA-Z]([a-zA-Z0-9]){2}|[a-zA-Z]([a-zA-Z0-9]){3}|[a-zA-Z]([a-zA-Z0-9]){4}|[a-zA-Z]([a-zA-Z0-9]){5}|[a-zA-Z]([a-zA-Z0-9]){6}|[a-zA-Z]([a-zA-Z0-9]){7}|[a-zA-Z]([a-zA-Z0-9]){8}|[a-zA-Z]([a-zA-Z0-9]){9}

FLOAT ([+-]?([1-9][0-9]*[.][0-9][0-9]?|[0][.]([1-9][0-9]?|[0-9][1-9]))|[0][.][0][0]?)
CHAR '([a-zA-Z0-9@_#+*-/\\.: ]|\\n)'
LISTA ({CHAR}([ ]{CHAR})*|{FLOAT}([ ]{FLOAT})*)[$]  
BOOL [01]

FIM_INSTRUCAO [;]
PAREN_ESQ [(]
PAREN_DIR [)]
CHAVE_ESQ [{]
CHAVE_DIR [}]

OPR_SOMA [+]
OPR_SUB [-]
OPR_MULT [*]
OPR_DIV [/]

OPR_E [\^]
OPR_OU [|]
OPR_NEG [~]

OPR_MAIORQ [>]
OPR_MENORQ [<]
OPR_IGUAL [=][=]
OPR_DIF [~][=]

%%

{PALAVRA_RESERVADA} {printf("[%s] -> PALAVRA RESERVADA\n", yytext);}
{OPR_ATRIB}         {printf("[%s] -> OPERADOR DE ATRIBUICAO\n", yytext);}
{ID}                {printf("[%s] -> IDENTIFICADOR\n", yytext);}
{FLOAT}             {printf("[%s] -> TIPO FLOAT\n", yytext);}
{CHAR}              {printf("[%s] -> TIPO CHAR\n", yytext);}
{LISTA}             {printf("[%s] -> TIPO LISTA\n", yytext);}
{BOOL}              {printf("[%s] -> TIPO BOOL\n", yytext);}
{FIM_INSTRUCAO}     {printf("[%s] -> SINAL DE FIM DE INSTRUCAO\n", yytext);}
{PAREN_ESQ}         {printf("[%s] -> PARENTESE A ESQUERDA\n", yytext);}
{PAREN_DIR}         {printf("[%s] -> PARENTESE A DIREITA\n", yytext);}
{CHAVE_ESQ}         {printf("[%s] -> CHAVE A ESQUERDA\n", yytext);}
{CHAVE_DIR}         {printf("[%s] -> CHAVE A DIREITA\n", yytext);}
{OPR_SOMA}          {printf("[%s] -> OPERADOR DE SOMA\n", yytext);}
{OPR_SUB}           {printf("[%s] -> OPERADOR DE SUBTRACAO\n", yytext);}
{OPR_MULT}          {printf("[%s] -> OPERADOR DE MULTIPLICACAO\n", yytext);}
{OPR_DIV}           {printf("[%s] -> OPERADOR DE DIVISAO\n", yytext);}
{OPR_E}             {printf("[%s] -> OPERADOR LOGICO E\n", yytext);}
{OPR_OU}            {printf("[%s] -> OPERADOR LOGICO OU\n", yytext);}
{OPR_NEG}           {printf("[%s] -> OPERADOR LOGICO DE NEGACAO\n", yytext);}
{OPR_MAIORQ}        {printf("[%s] -> OPERADOR DE MAIOR QUE\n", yytext);}
{OPR_MENORQ}        {printf("[%s] -> OPERADOR DE MENOR QUE\n", yytext);}
{OPR_IGUAL}         {printf("[%s] -> OPERADOR DE IGUALDADE\n", yytext);}
{OPR_DIF}           {printf("[%s] -> OPERADOR DE DIFERENCA\n", yytext);}
" "                 
.                   {printf("[%s] -> ERRO\n", yytext);}

%%

int main(void) {
   FILE *f = fopen("output.txt", "w");

   if (!f) {
      perror("Erro ao abrir arquivo!\n");
      return 1;
   }

   yylex();

   fclose(f);
   return 0;
}
