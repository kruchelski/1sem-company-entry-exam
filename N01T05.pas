Program N01T05 ;  // Cassiano K. Vidal e Gustado de Oliveira Achinitz
uses MODULOS;

var re:regis;
		ind:vetor;
		arqi: file of regis;
		vagastxt: text; //variavel pra carregar o arquiovo VAGAS.TXT
		a, idade, nas, e, x, t:integer;
		staux: string[36];
		regvagas: string[31]; //string para ler cada linha do arquivo
		clascargo,vagas: array [1..8] of integer; //Vetores para armazenar a classifica�ao por cargo e a quantidade de vagas por cago (baseada no arquivo de texto), respectivamente.
	
const base : integer = 20193112;  // Para calcular algo que seja semelhante a idade, baseando-se na data nos registros, fazer uma subtra��o utilizando um numero base que � definido aqui 		

Begin
	textcolor(lightred);
	writeln('REALIZANDO OPERA��ES....');
	textcolor(lightgreen);
	assign(arqi,'CAND.IND');
	assign(vagastxt,'VAGAS.TXT');
	reset(vagastxt);
	reset(arqi);
//--------- Organiza��o do vetor vagas conforme o arquivo de texto ----------//
	for x:=1 to 8 do
	Begin
		readln(vagastxt,regvagas);
		val(copy(regvagas,30,2),vagas[x],e);
	End;
	close(vagastxt);
	for x:=1 to 8 do
//----------Montagem do indice, utilizando como campo chave uma string que contem todas as informa��es necess�rias para gerar uma classifica��o------//
	a:=0;
	staux:='';
	while not(eof(arqi)) do
	Begin
	  a:=a+1;
		seek(arqi,a-1);
    read(arqi,re);
    ind[a].pf:=a-1;                                // Carrega o valor da posi��o f�sica. Em seguida vai come�ar a carregar a string que contem na seguinte ordem: Soma, N3,N4,N2,N1,Idade
    str(re.so:3,staux);                            // Converte re.so de integer para string armazenando em staux.
    ind[a].c_chave:=ind[a].c_chave + staux;        // Coloca o conteudo de staux no campo chave da posi��o atual do ind
    staux:='';                                     // Limpa a string staux
    str(re.n3:3,staux);                            // Converte re.n3 de integer para string armazenando em staux.
    ind[a].c_chave:=ind[a].c_chave + staux;        // Coloca o conteudo de staux no campo chave da posi��o atual do ind
    staux:='';                                     // Limpa a string staux    
    str(re.n4:3,staux);                            // Converte re.n3 de integer para string armazenando em staux.
    ind[a].c_chave:=ind[a].c_chave + staux;        // Coloca o conteudo de staux no campo chave da posi��o atual do ind	
    staux:='';                                     // Limpa a string staux			
    str(re.n2:3,staux);                            // Converte re.n3 de integer para string armazenando em staux.
    ind[a].c_chave:=ind[a].c_chave + staux;        // Coloca o conteudo de staux no campo chave da posi��o atual do ind
    staux:='';                                     // Limpa a string staux    
    str(re.n1:3,staux);                            // Converte re.n3 de integer para string armazenando em staux.
    ind[a].c_chave:=ind[a].c_chave + staux;        // Coloca o conteudo de staux no campo chave da posi��o atual do ind
    staux:='';                                     // Limpa a string staux
		val(re.data,nas,e);                            // Converte a data em um inteiro
		str((base-nas):6,staux);                       // Faz uma conta com a data e o valor base para extrair uma "idade" e depois converte em string e armazena em staux
		ind[a].c_chave:=ind[a].c_chave + staux;        // Coloca o conteudo de staux no campo chave da posi��o atual do ind
		staux:='';                                     // Limpa a string staux

	End;
//---------- Indice montado.-------------------------------------------------
 	
	 ordem(ind,a);                                       // Ordena o indice
 
//---------- Inicia o processo de atualiza��o do cadastro.-------------------
	t:=1;
	for x:=a downto 1 do
	Begin
		seek(arqi,ind[x].pf);
		read(arqi,re);
		re.clg:=t;
		clascargo[re.car]:=clascargo[re.car]+1;
		re.clc:=clascargo[re.car];
		if(clascargo[re.car]<=vagas[re.car]) then re.ccl:=re.car;
		seek(arqi,ind[x].pf);
		write(arqi,re);
		t:=t+1			
	End;



//---------- Processos de finaliza��o do programa ---------------------------	 
close(arqi);
writeln('Processo conclu�do!!');
delay(1000);
writeln;
textcolor(lightblue);
writeln('Pressione QUALQUER TECLA para finalizar');
readkey;
textcolor(lightred);
writeln;
writeln;
write('Encerrando');delay(150);write('.');delay(150);write('.');delay(150);writeln('.');delay(150);  
End.