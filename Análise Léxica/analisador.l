%{
   #include <stdio.h>
%}

COMENTARIO \\[a-zA-Z0-9@_#+*-/.: \n']*\\
PALAVRA_RESERVADA (FLOAT|CHAR|LISTA|BOOL|CONST|ESCREVER|LER|SE|ENTAO|SENAO|ENQUANTO|FAÇA|PROGRAMA|PREX)
ID [a-zA-Z][a-zA-Z0-9]{0,9}

FLOAT ([+-]?([1-9][0-9]*[.][0-9][0-9]?|[0][.]([1-9][0-9]?|[0-9][1-9]))|[0][.][0][0]?)
CHAR '([a-zA-Z0-9@_#+*-/\\.: ]|\\n)'
LISTA ({CHAR}([ ]{CHAR})*|{FLOAT}([ ]{FLOAT})*)[$]  

%%

{COMENTARIO}        {printf("[%s] -> COMENTARIO\n", yytext);}
{PALAVRA_RESERVADA} {printf("[%s] -> PALAVRA RESERVADA\n", yytext);}
[=]                 {printf("[%s] -> OPERADOR DE ATRIBUICAO\n", yytext);}
{ID}                {printf("[%s] -> IDENTIFICADOR\n", yytext);}
{FLOAT}             {printf("[%s] -> TIPO FLOAT\n", yytext);}
{CHAR}              {printf("[%s] -> TIPO CHAR\n", yytext);}
{LISTA}             {printf("[%s] -> TIPO LISTA\n", yytext);}
[01]                {printf("[%s] -> TIPO BOOL\n", yytext);}
[;]                 {printf("[%s] -> SINAL DE FIM DE INSTRUCAO\n", yytext);}
[(]                 {printf("[%s] -> PARENTESE A ESQUERDA\n", yytext);}
[)]                 {printf("[%s] -> PARENTESE A DIREITA\n", yytext);}
[{]                 {printf("[%s] -> CHAVE A ESQUERDA\n", yytext);}
[}]                 {printf("[%s] -> CHAVE A DIREITA\n", yytext);}
[+]                 {printf("[%s] -> OPERADOR DE SOMA\n", yytext);}
[-]                 {printf("[%s] -> OPERADOR DE SUBTRACAO\n", yytext);}
[*]                 {printf("[%s] -> OPERADOR DE MULTIPLICACAO\n", yytext);}
[/]                 {printf("[%s] -> OPERADOR DE DIVISAO\n", yytext);}
[\^]                {printf("[%s] -> OPERADOR LOGICO E\n", yytext);}
[|]                 {printf("[%s] -> OPERADOR LOGICO OU\n", yytext);}
[~]                 {printf("[%s] -> OPERADOR LOGICO DE NEGACAO\n", yytext);}
[>]                 {printf("[%s] -> OPERADOR DE MAIOR QUE\n", yytext);}
[<]                 {printf("[%s] -> OPERADOR DE MENOR QUE\n", yytext);}
[=][=]              {printf("[%s] -> OPERADOR DE IGUALDADE\n", yytext);}
[~][=]              {printf("[%s] -> OPERADOR DE DIFERENCA\n", yytext);}
" "                 
.                   {printf("[%s] -> ERRO\n", yytext);}

%%

// Para executar: flex analisador.l; gcc -o lex lex.yy.c -ll; ./lex < in_out_puts/bool_input.txt > output.txt
// Obs: Trocando "bool" pelo nome do arquivo desejado

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
