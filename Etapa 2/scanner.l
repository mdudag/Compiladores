%{
#include <stdio.h>
%}

%%
[\t]+                        {;/*ignora espa�os em branco */}
"ESCRITA"                    {printf("[%s] -> ESCRITA\n", yytext);}
"LEITURA"                    {printf("[%s] -> LEITURA\n", yytext);}
"float"                      {printf("[%s] -> FLOAT\n", yytext);}
[a-zA-Z][a-zA-Z0-9]          {printf("[%s] -> ID\n", yytext);}
[0-9]*[,][0-9]*              {printf("[%s] -> FLOAT\n", yytext);}
"+"                          {printf("[%s] -> OPERADOR DE SOMA\n", yytext);}
"-"                          {printf("[%s] -> OPERADOR DE SUBTRACAO\n", yytext);}
"*"                          {printf("[%s] -> OPERADOR DE MULTIPLICACAO\n", yytext);}
"/"                          {printf("[%s] -> OPERADOR DE DIVISAO\n", yytext);}
"("                          {printf("[%s] -> PARENTESE A ESQUERDA\n", yytext);}
")"                          {printf("[%s] -> PARENTESE A DIREITA\n", yytext);}
"{"                          {printf("[%s] -> CHAVE A ESQUERDA\n", yytext);}
"}"                          {printf("[%s] -> CHAVE A DIREITA\n", yytext);}
";"	                     {printf("[%s] -> PONTO VIRGULA\n", yytext);}
%%

int yywrap(){
return 1;
}

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
