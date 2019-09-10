%{
#include <stdlib.h>
#include <stdio.h>

enum { tk_int = 259, tk_char, tk_double = 260, tk_id = 256, tk_cte_int,tk_if = 258, tk_maig = 261, tk_string = 265, tk_coment = 266};
%}

WS	[ \t\n]
DIGITO	[0-9]
LETRA	[A-Za-z_$]
CHAR	{LETRA}|{NUM}|[* \t]
NUM	{DIGITO}+
ID	{LETRA}({LETRA}|{DIGITO})*
FLOAT	{NUM}("."{NUM})?([Ee]("+"|"-")?{NUM})?
STRING	["]({CHAR}|[\\][tn"])*["]
IF	[Ii][Ff]
COMNT	([\/][*]({CHAR}|[\/+])*[*][/]|[\/][\/]({CHAR}|[ \t\/])*[\n]?)

%%
    /* Padrões e ações. Nesta seção, comentários devem ter um tab antes */

{COMNT}	{ return tk_coment; }	
{NUM}	{ return tk_int; }
{FLOAT} { return tk_double; }
{STRING}	{return tk_string; }
{WS}	{ /* ignora espaços, tabs e '\n' */ } 
{IF}	{ return tk_if; }
"char"	{ return tk_char; }
"int"	{ return tk_int; }
"double"	{ return tk_double; }
">="	{ return tk_maig; }
{ID}	{ return tk_id; }
.       { return *yytext; 
          /* Essa deve ser a última regra. Dessa forma qualquer caractere isolado será retornado pelo seu código ascii. */ }

%%

/* Não coloque nada aqui - a função main é automaticamente incluída na hora de avaliar e dar a nota. */
