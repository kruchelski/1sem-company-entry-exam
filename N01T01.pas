Unit N01T01;
Interface

type
nvet = array [1..2000] of string[36];

// Resumo dos m�dulos dispon�veis para chamada num programa que utilizar esta unit

Function validata(d,m,a: integer): boolean;
Function validacpf(cpf:string): boolean;
Procedure ordenar(var nome:nvet; ind:integer);
Function pesquisa(nome:nvet; ind:integer; ext:string[36]):integer;



// Imprementa��o dos m�dulos, com todas as instru��es de cada um

Implementation

// Fun��o de validar data-----------------------------------------------------------------
Function validata(d,m,a: integer): boolean;
var dm:integer;
data:BOOLEAN;
Begin
  data:=true;
  if(a<0) then
  data:=false // Valida��o do ano pra ver se n�o foi digitado um n�mero negativo
  else if (m<1) or (m>12) then
  data:=false // Valida��o do m�s pra ver se n�o foi digitado um m�s menor que 1 ou maior que 12
  else
  Begin   //Defini��o do �ltimo dia do m�s baseando-se em qual m�s � e se o ano � bissexto.
    dm:=31;
    if (m=4) or (m=6) or (m=9) or (m=11) then //Verifica se n�o � um m�s com 30 dias
    dm:=30
    else if (m=2) then // Verifica se � fevereiro e atribui o n�mero m�ximo de dias para 28
    Begin
      dm:=28;
      if (((((a mod 4)=0)and((a mod 100)<>0))or((a mod 400) = 0))and (m=2)) then // Verifica se o ano bissexto. Caso positivo atribui o n�mero m�ximo de dias para 29
      dm:=29;
    End;
    if (d<1) or (d>dm) then // Testa se o dia digitado n�o � menor que 1 ou maior que o �ltimo dia do m�s.
    data:=false;
  End;
  validata:=data; //Atribui o valor true ou false para a fun��o de acordo com a valida��o
End;
// Fim da fun��o de valida��o de data-----------------------------------------------------

// Fun��o de validar CPF------------------------------------------------------------------
Function validacpf(cpf:string[11]):boolean;
var cpfaux :boolean;
a,b,m,e,soma,numeq: integer;
dvs:string;
vet: array [1..11] of integer;

Begin
  cpfaux:=true;
  for b:=1 to 11 do  //Confere se os algarismos do CPF n�o s�o iguais (ex: 222.222.222-22)
  Begin
    if cpf[b]=cpf[1] then    //Verificar se todos os n�meros do CPF s�o iguais.
    numeq:=numeq+1;
  End;
  if numeq=11 then
  cpfaux:=false
  else
  Begin
    for a:=1 to 11 do
    val(CPF[a],vet[a],e); // Passando os valores digitados no CPF do formato string para o formato vetor integer.
    m:=10;
    a:=0;
    repeat
      soma:=0;
      a:=a+1;
      m:=m+1;
      for b:=1 to (m-2) do
    soma:=soma+vet[b]*(m-b); // Come�a o algoritmo de verifica��o fazendo a soma dos digitos multiplicados pelo n�mero que vai diminuindo
    soma:= (soma*10) mod 11;  // Pega a soma, multiplica por 10 e pega o resto da divis�o por 11
    if (soma=10  ) then         //Se o resultado da multiplica��o/divisao for 10, transforma em 0
    soma:=0;
    if (soma <> vet[m-1]) then    //Compara a conta com o digito verificador
    cpfaux:=false
  until ((a=2) or (not cpfaux));
  validacpf:=cpfaux;
End;
End;
// Fim da fun��o de valida��o do CPF---------------------------------------------------------

// Procedure de ordena��o -------------------------------------------------------------------
Procedure ordenar(var nome:nvet; ind:integer);
var tot,a:integer;
aux:string[36];
troca:boolean;

Begin
  tot:=ind;
  repeat
    troca:=true;
    tot:=tot-1;
    for a:=1 to tot do
    if(nome[a] > nome[a+1]) then
    Begin
      aux:=nome[a];
      nome[a]:=nome[a+1];
      nome[a+1]:=aux;
      troca:=false;
    End;
  until troca;
End;
// Fim do Procedure de ordena��o-------------------------------------------------------------

// Fun��o de pesquisa bin�ria
Function pesquisa(nome:nvet; ind:integer; ext:string[36]):integer;
var achou: boolean;
ini,fim,meio: integer;

Begin
  achou:=false;
  ini:=1;
  fim:=ind;
  repeat
    meio:=(ini+fim) div 2;
    if( ext = nome[meio])then
    achou:=true
    else if(ext > nome[meio])then
    ini:=meio+1
    else
    fim:=meio-1;
  until ((achou) or (ini > fim));
  if (achou) then
  pesquisa:= meio
  else 
	pesquisa:=0;
End;
end.             