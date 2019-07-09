Unit N01T01;
Interface

type
nvet = array [1..2000] of string[36];

// Resumo dos módulos disponíveis para chamada num programa que utilizar esta unit

Function validata(d,m,a: integer): boolean;
Function validacpf(cpf:string): boolean;
Procedure ordenar(var nome:nvet; ind:integer);
Function pesquisa(nome:nvet; ind:integer; ext:string[36]):integer;



// Imprementação dos módulos, com todas as instruções de cada um

Implementation

// Função de validar data-----------------------------------------------------------------
Function validata(d,m,a: integer): boolean;
var dm:integer;
data:BOOLEAN;
Begin
  data:=true;
  if(a<0) then
  data:=false // Validação do ano pra ver se não foi digitado um número negativo
  else if (m<1) or (m>12) then
  data:=false // Validação do mês pra ver se não foi digitado um mês menor que 1 ou maior que 12
  else
  Begin   //Definição do último dia do mês baseando-se em qual mês é e se o ano é bissexto.
    dm:=31;
    if (m=4) or (m=6) or (m=9) or (m=11) then //Verifica se não é um mês com 30 dias
    dm:=30
    else if (m=2) then // Verifica se é fevereiro e atribui o número máximo de dias para 28
    Begin
      dm:=28;
      if (((((a mod 4)=0)and((a mod 100)<>0))or((a mod 400) = 0))and (m=2)) then // Verifica se o ano bissexto. Caso positivo atribui o número máximo de dias para 29
      dm:=29;
    End;
    if (d<1) or (d>dm) then // Testa se o dia digitado não é menor que 1 ou maior que o último dia do mês.
    data:=false;
  End;
  validata:=data; //Atribui o valor true ou false para a função de acordo com a validação
End;
// Fim da função de validação de data-----------------------------------------------------

// Função de validar CPF------------------------------------------------------------------
Function validacpf(cpf:string[11]):boolean;
var cpfaux :boolean;
a,b,m,e,soma,numeq: integer;
dvs:string;
vet: array [1..11] of integer;

Begin
  cpfaux:=true;
  for b:=1 to 11 do  //Confere se os algarismos do CPF não são iguais (ex: 222.222.222-22)
  Begin
    if cpf[b]=cpf[1] then    //Verificar se todos os números do CPF são iguais.
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
    soma:=soma+vet[b]*(m-b); // Começa o algoritmo de verificação fazendo a soma dos digitos multiplicados pelo número que vai diminuindo
    soma:= (soma*10) mod 11;  // Pega a soma, multiplica por 10 e pega o resto da divisão por 11
    if (soma=10  ) then         //Se o resultado da multiplicação/divisao for 10, transforma em 0
    soma:=0;
    if (soma <> vet[m-1]) then    //Compara a conta com o digito verificador
    cpfaux:=false
  until ((a=2) or (not cpfaux));
  validacpf:=cpfaux;
End;
End;
// Fim da função de validação do CPF---------------------------------------------------------

// Procedure de ordenação -------------------------------------------------------------------
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
// Fim do Procedure de ordenação-------------------------------------------------------------

// Função de pesquisa binária
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