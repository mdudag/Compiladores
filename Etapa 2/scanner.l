%{

// Para executar no linux: flex scanner.l; gcc -o scanner lex.yy.c -lfl; ./scanner input.txt output.txt > output.txt

#include <stdio.h>
int yywrap(void);

%}

COMENTARIO \\[a-zA-Z0-9@_#+*-/.$: \n']*\\
PALAVRA_RESERVADA (FLOAT|ESCREVER|LER|PROGRAMA|PREX)
ID [a-zA-Z][a-zA-Z0-9]{0,9}
FLOAT ([+-]?([1-9][0-9]*[.][0-9][0-9]?|[0][.]([1-9][0-9]?|[0-9][1-9]))|[0][.][0][0]?)
VAR_FLOAT FLOAT[ ]{ID}([,][ ]{ID})*[;]

%%

[\t ]+              {/* Ignora espacos em branco */}
{COMENTARIO}        {printf("[%s] -> COMENTARIO\n", yytext);}
{PALAVRA_RESERVADA} {printf("[%s] -> PALAVRA RESERVADA\n", yytext);}
{ID}                {printf("[%s] -> IDENTIFICADOR\n", yytext);}
{FLOAT}             {printf("[%s] -> TIPO FLOAT\n", yytext);}
{VAR_FLOAT}         {printf("[%s] -> VARIAVEL TIPO FLOAT\n", yytext);}
"="                 {printf("[%s] -> OPERADOR DE ATRIBUICAO\n", yytext);}
"+"                 {printf("[%s] -> OPERADOR DE SOMA\n", yytext);}
"-"                 {printf("[%s] -> OPERADOR DE SUBTRACAO\n", yytext);}
"*"                 {printf("[%s] -> OPERADOR DE MULTIPLICACAO\n", yytext);}
"/"                 {printf("[%s] -> OPERADOR DE DIVISAO\n", yytext);}
"("                 {printf("[%s] -> PARENTESE A ESQUERDA\n", yytext);}
")"                 {printf("[%s] -> PARENTESE A DIREITA\n", yytext);}
"{"                 {printf("[%s] -> CHAVE A ESQUERDA\n", yytext);}
"}"                 {printf("[%s] -> CHAVE A DIREITA\n", yytext);}
";"	              {printf("[%s] -> PONTO VIRGULA\n", yytext);}
.                   {printf("[%s] -> ERRO\n", yytext);}

%%

int main(int argc, char **argv) {
   if(argc < 3){
	   printf("Os parametros corretos sao: %s <arquivo de entrada> <arquivo de saida>\n", argv[0]);
   }
   
   FILE *input = fopen(argv[1],"r");
   if(!input) {
      printf("Erro ao abrir arquivo de entrada\n");
      return 1;
   }
   
   FILE *output = fopen(argv[2],"w");
   if(!output) {
      printf("Erro ao abrir arquivo de saida\n");
      return 1;
   }

   yyin = input;
   yylex();

   fclose(input);
   fclose(output);
   return 0;
}

int yywrap(void) {
   return 1;
}
