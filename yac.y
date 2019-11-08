
 %{
// Includes em C/C++ e outras definições.
#include <iostream>
#include <string>
#include <map>

using namespace std;

struct Atributos {
  string v;
};

// Tipo dos atributos: YYSTYPE é o tipo usado para os atributos.
#define YYSTYPE Atributos

void erro( string msg );
void print( string st );

// protótipo para o analisador léxico (gerado pelo lex)
int yylex();
void yyerror( const char* );

%}

// Tokens
%token	 ID NUM PRINT STRING

%%

DeclVar : 'let' Var ';' 
  ;

Var : ID MeioVar 
  | ID Colc MeioVar
  ;
  
MeioVar : ID MeioVar 
  | Colc MeioVar 
  | Atrib MeioVar 
  | '{},' Var 
  | '{};'
  ;
  
Const : int Op 
  | double Op
  | string Op
  ;
  
  
Op : '+' RHS 
  | '-' RHS
  | '*' RHS
  | '/' RHS
  ;
  
RHS : Op id 
  | Op Const
  ;

Colc : '[]' Colc
  | '[' Valor ']' Colc 
  |
  ;
  
Atrib : '=' Const Op
  | '=' id Op
  | '=' '[]'
  ;
  
Valor: id Op 
  | Const
  ;

tk_if : '(' Bool ')'
  | '(' Bool ')' Else 
  ;    

Else : Bloco 
  | tk_if 
  ;
  
While : '(' Bool ')' Bloco

Bool : true Bool |
  false Bool |
  Valor Bool |
  Bool Comparador Bool |
  '&&' Bool |
  '||' Bool |
  |
  ;
 
Comparador : '==' |
  '!=' |
  '>=' |
  '<=' |
  '<' |
  '>' |
  ;
  
For : '(' DeclVar| ';' Bool ';' Var ')' Bloco |
  (' DeclVar| ';' Bool ';' Var ')' Bloco |
  ;
  
Bloco : Bloco
  ;


%%


#include "lex.yy.c"

void yyerror( const char* msg ) {
  cout << endl << "Erro: " << msg << endl
       << "Perto de : '" << yylval.v << "'" <<endl;
  exit( 0 );
}

void print( string st ) {
  cout << st << " ";
}

int main() {
  yyparse();
  cout << endl;
}
