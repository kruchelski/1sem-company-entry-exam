unit modulos;

interface
		 type
		 a36=string[36];
		 regis=record
      num:integer;
      nome:a36;
      cpf:string[11];
      data:string[8];
      car,n1,n2,n3,n4,so,clg,clc,ccl:integer
     end;
		 cc=record
      pf:integer;
      c_chave:a36;
     end;
     vetor=array[1..2000] of cc;
		 vet1=array[1..2000] of a36;

 PROCEDURE pebin1(vet:vetor;ext:a36;t:integer;VAR CC:INTEGER);
 function valdat(d,m,a:integer):boolean;
 function vercpf(num:string[11]):boolean;
 procedure ordea(var vet:vet1; t:integer);
 procedure ordem(var vet:vetor; t:integer);
implementation
//-----ordena vetor contento em cada posicao a estrutura registro PF+CAMPO CHAVE
procedure ordem(var vet:vetor; t:integer);
var aux:cc;
    tot,a,jt:integer;
    tro:boolean;
begin
 tot:=t;
 jt:=1;
 repeat
  tro:=true;
  tot:=tot-jt;
  for a:=1 to tot do
   if(vet[a].c_chave > vet[a+1].c_chave) then
    begin
     aux:=vet[a];
     vet[a]:=vet[a+1];
     vet[a+1]:=aux;
     tro:=false;
     jt:=1;
    end
   else
    jt:=jt+1;
 until tro;
end;
//-----ordena um vetor contendo em cada posicao um STRING[36]
procedure ordea(var vet:vet1; t:integer);
var aux:a36;
    tot,a,jt:integer;
    tro:boolean;
begin
 tot:=t;
 jt:=1;
 repeat
  tro:=true;
  tot:=tot-jt;
  for a:=1 to tot do
   if(vet[a] > vet[a+1]) then
    begin
     aux:=vet[a];
     vet[a]:=vet[a+1];
     vet[a+1]:=aux;
     tro:=false;
     jt:=1;
    end
   else
    jt:=jt+1;
 until tro;
end;
//------valida uma data
function valdat(d,m,a:integer):boolean;
   var dm:integer;
       DAT:BOOLEAN;
BEGIN
   DAT:=TRUE;
   IF(A<1900)THEN  //ano
    DAT:=FALSE
   ELSE
    IF(M<1) OR (M>12) THEN  //mes
     DAT:=FALSE
    ELSE
     BEGIN //dia
      DM:=31;
      IF(M=4) OR (M=6) OR (M=9) OR (M=11) THEN  //meses com 30 dias
       DM:=30;
      IF(M=2) THEN //fevereiro
       BEGIN
        DM:=28;
        IF(A MOD 4) = 0 THEN  //bissesto
         DM:=29;
       end;
      IF(D<1) OR (D>DM) THEN
       DAT:=FALSE
      END;
    valdat:=dat;
  END;
//-----pequisa binaria

PROCEDURE pebin1(vet:vetor;ext:a36;t:integer;VAR CC:INTEGER);
var ii,i9,meio:integer;
    achou:boolean;
begin
 achou:=false;
 ii:=1;
 i9:=t;
 repeat
  meio:=(ii+i9) div 2;
  if(ext = vet[meio].c_chave)then
	  achou:=true
  else
   if(ext > vet[meio].c_chave)then
    ii:=meio+1
   else
    i9:=meio-1;
 until ((achou) OR (ii > i9));
 if( achou ) then
  CC := meio
 else
  CC := 0;
end;
//-----valida CPF
function vercpf(num:string[11]):boolean;
var vet:array[1..11] of integer;
    dvs:array[1..2] of integer;
    som,a,b,e,f,m,r:integer;
    aux:boolean;
begin
 aux:=true;
 for a:=1 to 11 do
  val(num[a],vet[a],e);{o string "num" já vem validado}
 f:=8;
 m:=10;
 a:=0;
 repeat
   som:=0;
   a:=a+1;
	 f:=f+1;
	 m:=m+1;
	 for b:=1 to f do
	  som:=som+vet[b]*(m-b);
   r:=som mod 11;
   dvs[a]:=11-r;
   if(r<2)then
    dvs[a]:=0;
   if(vet[m-1] <> dvs[a])then
    aux:=false;
 until ((a=2) or (not aux));
 vercpf:=aux;
end;
end.
