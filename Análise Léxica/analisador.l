%{
   // Para executar no linux: 
   //    - flex analisador.l; gcc -o lex lex.yy.c -ll
   //    - Ver resultado na linha de comando: ./lex in_out_put/Exemplo01.prex output.txt
   //    - Ver resultado no arquivo de saída: ./lex in_out_put/Exemplo01.prex output.txt > output.txt

   // Para executar no windows no programa Cygwin64: inserir o caminho da pasta onde está o arquivo.l (ex: cd /cydrive/c/Users/(...); flex lex.l; gcc lex.yy.c -o lex - lfl; ./lex)
   // Para abrir o input e o output no terminal Cygwin: ./lex input.txt output.txt; e no próximo passo: cat output.txt
   
   #include <stdio.h>
%}

COMENTARIO \\[a-zA-Z0-9@_#+*-/.$: \n']*\\
PALAVRA_RESERVADA (FLOAT|CHAR|LISTA|BOOL|CONST|ESCREVER|LER|SE|ENTAO|SENAO|ENQUANTO|FACA|PROGRAMA|PREX)
ID [a-zA-Z][a-zA-Z0-9]{0,9}

FLOAT ([+-]?([1-9][0-9]*[.][0-9][0-9]?|[0][.]([1-9][0-9]?|[0-9][1-9]))|[0][.][0][0]?)
CHAR '([a-zA-Z0-9@_#+*-/\\.$: ]|\\n)'
LISTA_CHAR ({CHAR}[ ])+'$'|["]([a-zA-Z0-9@_#+*-/\\.$: ]|\\n)+["]
LISTA_FLOAT ({FLOAT}[ ])+'$'
BOOL [01]

VAR_FLOAT FLOAT[ ]{ID}([,][ ]{ID})*[;]
VAR_BOOL BOOL[ ]{ID}([,][ ]{ID})*[;]
VAR_CHAR CHAR[ ]{ID}([,][ ]{ID})*[;]
VAR_LISTA_CHAR LISTA[ ]CHAR[ ]{ID}[(][0-9]+[)]([,][ ]{ID}[(][0-9]+[)])*[;]
VAR_LISTA_FLOAT LISTA[ ]FLOAT[ ]{ID}[(][0-9]+[)]([,][ ]{ID}[(][0-9]+[)])*[;]

CONST_FLOAT CONST[ ]FLOAT[ ]{ID}[ ]{FLOAT}[;]
CONST_BOOL CONST[ ]BOOL[ ]{ID}[ ]{BOOL}[;]
CONST_CHAR CONST[ ]CHAR[ ]{ID}[ ]{CHAR}[;]
CONST_LISTA_CHAR CONST[ ]LISTA[ ]CHAR[ ]{ID}[(][0-9]+[)][ ]{LISTA_CHAR}[;]
CONST_LISTA_FLOAT CONST[ ]LISTA[ ]FLOAT[ ]{ID}[(][0-9]+[)][ ]{LISTA_FLOAT}[;]

%%

{COMENTARIO}        {printf("[%s] -> COMENTARIO\n", yytext);}
{PALAVRA_RESERVADA} {printf("[%s] -> PALAVRA RESERVADA\n", yytext);}
[=]                 {printf("[%s] -> OPERADOR DE ATRIBUICAO\n", yytext);}
{ID}                {printf("[%s] -> IDENTIFICADOR\n", yytext);}
{FLOAT}             {printf("[%s] -> TIPO FLOAT\n", yytext);}
{CHAR}              {printf("[%s] -> TIPO CHAR\n", yytext);}
{LISTA_CHAR}        {printf("[%s] -> TIPO LISTA CHAR\n", yytext);}
{LISTA_FLOAT}       {printf("[%s] -> TIPO LISTA FLOAT\n", yytext);}
{BOOL}              {printf("[%s] -> TIPO BOOL\n", yytext);}
{VAR_FLOAT}         {printf("[%s] -> VARIAVEL TIPO FLOAT\n", yytext);}
{VAR_BOOL}          {printf("[%s] -> VARIAVEL TIPO BOOL\n", yytext);}
{VAR_CHAR}          {printf("[%s] -> VARIAVEL TIPO CHAR\n", yytext);}
{VAR_LISTA_CHAR}    {printf("[%s] -> VARIAVEL TIPO LISTA CHAR\n", yytext);}
{VAR_LISTA_FLOAT}   {printf("[%s] -> VARIAVEL TIPO LISTA FLOAT\n", yytext);}
{CONST_FLOAT}       {printf("[%s] -> CONSTANTE TIPO FLOAT\n", yytext);}
{CONST_BOOL}        {printf("[%s] -> CONSTANTE TIPO BOOL\n", yytext);}
{CONST_CHAR}        {printf("[%s] -> CONSTANTE TIPO CHAR\n", yytext);}
{CONST_LISTA_CHAR}  {printf("[%s] -> CONSTANTE TIPO LISTA CHAR\n", yytext);}
{CONST_LISTA_FLOAT} {printf("[%s] -> CONSTANTE TIPO LISTA FLOAT\n", yytext);}
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
[ \t]                 
.                   {printf("[%s] -> ERRO\n", yytext);}

%%

int main(int argc, char **argv) {
   if(argc < 3){
	printf("Os parametros corretos sao: %s <arquivo de entrada> <arquivo de saida>\n", argv[0]);
   }
   
   FILE *input = fopen(argv[1],"r");
   if(!input){
      printf("Erro ao abrir arquivo de entrada\n");
      return 1;
   }
   
   FILE *output = fopen(argv[2],"w");
   if(!output){
      printf("Erro ao abrir arquivo de saida\n");
      return 1;
   }

   yyin = input;
   yylex();

   fclose(input);
   fclose(output);
   return 0;
}
