%{
#include <stdio.h>

#define CLASE_NUMERO 1
#define CLASE_REAL 2
#define CLASE_ARREGLO 3
#define CLASE_ID 4
#define CLASE_RESERVADAS 5
#define CLASE_PUNTUACION 6
#define CLASE_OP_BOOLEANO 7
#define CLASE_VAL_BOOLEANO 8
#define CLASE_OP_ARITMETICO 9
#define CLASE_OP_RELACIONAL 10
%}
reservadas @if|@else|@while
letra [a-zA-Z]
digito [0-9]
entero {digito}+
op_arit [+*/%]|[-]
op_rel [<>=]|<=|>=|<>

blanco [ \t\n]
puntuacion ;|y|"{"|"}"|"("|")"|,
asignacion :=



inicio_comen2 <*
fin_comen2 "*">

id #({digito}|{letra})+

%x COMILLAS
%x COMEN1
%x COMEN2
%%
{blanco}+ {}
{reservadas} {printf("clase reservadas %s \n", yytext); return CLASE_RESERVADAS;}
{id} {printf("clase id %s \n", yytext); return CLASE_ID;}
{entero} {printf("clase numero %s \n", yytext); return CLASE_NUMERO;}

{op_arit} {printf("clase op aritmetico %s \n", yytext); return CLASE_OP_ARITMETICO;}
{op_rel} {printf("clase op relacional %s \n", yytext); return CLASE_OP_RELACIONAL;}

{puntuacion} {printf("clase puntuación %s \n", yytext); return CLASE_PUNTUACION;}



-- { BEGIN (COMEN1); printf("Encontré comentario %s \n", yytext);}
<COMEN1>. {}
<COMEN1>\n { BEGIN(INITIAL); printf("salgo de comentario %s \n", yytext);}

{inicio_comen2} { BEGIN (COMEN2); printf("Encontré comentario %s \n", yytext);}
<COMEN2>{fin_comen2} { BEGIN(INITIAL); printf("salgo de comentario %s \n", yytext);}
<COMEN2>. {}


%%

int main(){

    yyin = fopen("prueba.txt", "r");
    yylex();

    
}
