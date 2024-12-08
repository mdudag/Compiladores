%{

// Para executar no linux:
//      bison -d parser.y; flex scanner.l; gcc -o parser parser.tab.c lex.yy.c -lfl; 
//      Executar: ./parser input.txt output.txt > main.c
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex(void);
extern int yywrap(void);
void yyerror(const char *msg);

char *dup;
char str[100][11];
int i=0;

%}

%union {
    char* s;
    float f;
}

%token PROGRAMA PREX FLOAT ESCREVER LER PV
%token <s> ID <f> TIPO_FLOAT
%token '=' '+' '-' '*' '/' '{' '}' ','

%left '+' '-'
%left '*' '/'

%start s    // Variável inicial

%%

    s: PROGRAMA PREX '{' {printf("#include <stdio.h>\n\nint main() {\n");} a
     ;

    /* Declaração de variáveis */
    a: FLOAT ID {printf("   float %s", $2);} b PV {printf(";");} a
     | c
     ;

    b: b ',' ID {printf(", %s", $3);}
     | {/* Cadeia vazia */}

    /* Comando de escrita, leitura e inicialização de variáveis */
    c: ESCREVER ID {
            strcpy(str[i], $2); ++i;
            printf("   printf(\""); 
       } 
       d {
            int aux=i;

            printf("%%s"); --i;
            while (i>0) {
                printf(", %%s"); --i;
            }

            printf("\\n\"");
            while (i<aux) {
                printf(", %s", str[i]); ++i;
            }

            i=0;
       }
       PV {printf(");");}  c 
     | LER ID {
            strcpy(str[i], $2); ++i;
            printf("   scanf(\""); 
       } 
       d {
            int aux=i;

            printf("%%s"); --i;
            while (i>0) {
                printf(" %%s"); --i;
            }

            printf("\"");
            while (i<aux) {
                printf(", &%s", str[i]); ++i;
            }

            i=0;
       }
       PV {printf(");");} c
     | ID '=' {printf("   %s = ", $1);} f PV {printf(";");} c
     | '}' {printf("\n   return 0;\n}");}
     ;

    d: d ID {strcpy(str[i], $2); ++i;}
     | /* Cadeia vazia */
     ;

    f: i
     | g
     ;

    g: op i {printf(" %s ", dup);} h
     ; 

    h: i
     | i {printf(" %s ", dup);} h
     | g
     ;

    op: '+' {dup = strdup("+");} 
      | '-' {dup = strdup("-");} 
      | '*' {dup = strdup("*");}
      | '/' {dup = strdup("/");}  
      ;

    i: ID {printf("%s", $1);}
     | TIPO_FLOAT {printf("%.2f", $1);}
     ;

%%

int main(int argc, char **argv) {
    if(argc < 3) {
        printf("ERRO! Os parametros corretos sao: %s <arquivo de entrada> <arquivo de saida>\n", argv[0]);
    }

    FILE *input = fopen(argv[1],"r");
    if (!input) {
        printf("Erro ao abrir arquivo de entrada!\n");
        fclose(input);
        return 1;
    }

    extern FILE *yyin;
    yyin = input;

    FILE *output = fopen(argv[2],"w");
    if (!output) {
        printf("Erro ao abrir arquivo de saida!\n");
        fclose(input); fclose(output);
        return 1;
    }

    yyparse();

    fclose(input);
    fclose(output);
    return 0;
}

int yywrap(void) {
    return 1;
}

void yyerror(const char *msg) {
    printf("ERRO: %s\n", msg);
}
