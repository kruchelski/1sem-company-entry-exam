Program N01T06 ; {Cassiano Kruchelski Vidal e Gustavo de Oliveira Achinitz}
uses MODULOS;

var	re:regis;
		arqi:file of regis;
		ind:vetor;
		a, len, op, e, t, x, i, j:integer;
		opaux:string[1];
		ord:string[15];
		staux:string;
		curso:array [1..8] of string[28];
		vagas:text;
		vagasaux:string[31];
Procedure cabeca(o:integer); //============================================== Cabeçalho ============================
Begin
	if o=1 then
	Begin
		clrscr;
		writeln;
		textcolor(lightgreen); // Curso x vai mostrar o conteúdo do vetor curso na posição x que contém o nome do curso
		writeln(' CURSO:  ',x,' ',curso[x],'               '); 
		writeln; 
		writeln(' ORD NUM  NOME                                 NASCIMENTO CAR');
		textcolor(white);
	End
	
	Else if o=2 then
	Begin
		clrscr;
		writeln;
		textcolor(lightgreen); // Curso x vai mostrar o conteúdo do vetor curso na posição x que contém o nome do curso
		writeln(' CURSO:  ',i,' ',curso[i],'                                               '); 
		writeln;                                                                          
		writeln(' ORD INSC NOME                                 SOM  N3  N4  N2  N1 NASCIMENTO CAR OBSERVAÇÃO');
		textcolor(white);
	End
	
	Else if o=3 then
	Begin
		clrscr;
		writeln;
		textcolor(lightgreen); // Curso x vai mostrar o conteúdo do vetor curso na posição x que contém o nome do curso
		writeln(' RELAÇÃO ORDEM DE CLASSIFICAÇÃO GERAL                                               '); 
		writeln;                                                                          
		writeln(' ORD INSC NOME                                 SOM  N3  N4  N2  N1 NASCIMENTO CAR OBSERVAÇÃO');
		textcolor(white);	
	End;
End;

Begin
	assign(vagas,'VAGAS.TXT');
	reset(vagas);
	for a:=1 to 8 do
	Begin
		readln(vagas,vagasaux);
		curso[a]:=copy(vagasaux,2,27);	
	End;
	close(vagas);
	op:=5;   // Op setado em 5 para rodar o programa (pois se estivesse em 0, ele não faria o laço principal do while).
  assign(arqi,'CAND.IND');
  reset(arqi);
  while(op<>0) do
  Begin // O programa foi colocado dentro de um laço para o caso do usuário querer ver em outra forma de ordenção após o fim de uma visualização.
    //============================== "menu principal" =============================================================
    clrscr;
    textcolor(lightgreen);
    writeln('========================= ENLATADOS ========================');
    writeln('=                                                          =');
    writeln('=              Visualização do resultado final             =');
    writeln('=                                                          =');
    writeln('= ---------------------------------------------------------=');
    writeln;
    textcolor(white);
    writeln('Digite a opção correspondente a forma de ordenação desejada:');
    writeln('1) Ordem de classificação POR CARGO e EM ORDEM ALFABÉTICA - Apenas candidatos aprovados');
    writeln('2) Ordem de classificação GERAL e POR CARGO - Todos os candidatos');
    writeln('3) Ordem de classificação GERAL - Todos os candidatos');
    writeln('------------------------------------------------------------');
    textcolor(red);
		writeln('0) Encerra o programa...');
    textcolor(white);
		writeln;
    repeat  // Validar a opção lida
      write('Opção: ');
      readln(opaux);
      writeln;
      val(opaux,op,e);
      if(e<>0) then writeln('Opção contém erro de digitação. Digite novamente')            // Caso seja digitado algo que não seja um número
      else if(op<0)or(op>3) then writeln('Opção inválida. Digite uma opção dentre as disponíveis'); // Caso seja digitado um número, porém fora das opções disponíveis
      writeln;
    until((e=0)and((op>=0)and(op<=3)));
    
    if (op=0) then  // Caso seja selecionada a opção para encerrar o programa, aparecerá uma mensagem informando o encerramento
    Begin
    	textcolor(lightred);
      write('Encerrando');delay(100);write('.');delay(100);write('.');delay(100);writeln('.');delay(100);
    End
    
    
    else  //========================== Aqui inicia a leitura do arquivo para preencher o índice
    Begin
    	clrscr;
    	textcolor(lightred);
    	writeln('MONTANDO ÍNDICE');
    	writeln;
    	
    	t:=0; // t é zerado pois é possível que o programa rode mais do que uma ordenação na mesma instância, logo poderia dar problema sem zerar o t.
      a:=0; // a é zerado pois é possível que o programa rode mais do que uma ordenação na mesma instância, logo poderia dar problema sem zerar o a.
      while not(eof(arqi)) do
      Begin // ======= Início da ordenação conforme a opção selecionada pelo usuário.
        if (op=1) then
        Begin
        	a:=a+1;
      		seek(arqi,a-1);
        	read(arqi,re);
          if re.ccl<>0 then // Só vai entrar para o índice o candidato que tiver sido aprovado, logo, quem tiver o campo ccl diferente de zero.
          Begin  
      			t:=t+1;
      			ind[t].c_chave:=''; // Como a exibição poderá ser realizada mais de uma vez sem encerrar o programa, ao fazer isso garante que o c_chave esteja limpo
      			ind[t].pf:=0;       // Como a exibição poderá ser realizada mais de uma vez sem encerrar o programa, ao fazer isso garante que o pf esteja limpo
        		ind[t].pf:=a-1;
						str(re.car,ind[t].c_chave);
						ind[t].c_chave:= ind[t].c_chave + re.nome;
          End;
        End
        
        
        else if (op=2) then 
				Begin
					a:=a+1;
					t:=t+1;
      		seek(arqi,a-1);
        	read(arqi,re);
      		ind[a].c_chave:=''; // Como a exibição poderá ser realizada mais de uma vez sem encerrar o programa, ao fazer isso garante que o c_chave esteja limpo
      		ind[a].pf:=0;       // Como a exibição poderá ser realizada mais de uma vez sem encerrar o programa, ao fazer isso garante que o pf esteja limpo
        	ind[a].pf:=a-1;
					str(re.car,ind[a].c_chave);
					str(re.clg:3,staux);
					ind[a].c_chave := ind[a].c_chave + staux;
        End
        
				else if (op=3) then 
				Begin
					a:=a+1;
					t:=t+1;
      		seek(arqi,a-1);
        	read(arqi,re);
      		ind[a].c_chave:=''; // Como a exibição poderá ser realizada mais de uma vez sem encerrar o programa, ao fazer isso garante que o c_chave esteja limpo
      		ind[a].pf:=0;       // Como a exibição poderá ser realizada mais de uma vez sem encerrar o programa, ao fazer isso garante que o pf esteja limpo
        	ind[a].pf:=a-1;
					str(re.clg:3,ind[a].c_chave);
        End;
		  End; // ======= Fim da montagem do vetor baseada na opção no início do programa ========================================================

			clrscr;  //
			writeln('ORDENANDO...');
      textcolor(white);

      ordem(ind,t); // Ordenação

 //====================================================================================================================================================================			 
      x:=0;   // Vai ser necessário para aparecer o nome correto do curso na exibição (baseado no indice do vetor curso)
 			i:=1;   // i Vai ser utilizado para verificar se está na hora de mostrar outro cargo (compara o i com o cargo do registro atual)
			j:=0;   // j vai ser utilizado para fazer a contagem de linhas por página 
			
			//cabeca(op);

			for a:=1 to t do  // ----------------------- Início da exibição.
 			Begin
 				seek(arqi,ind[a].pf);
   			read(arqi,re);
   			if (((op<=2) and ((re.car > i)or(j mod 40 = 0))) or ((op=3)and(j mod 40 = 0)))  then  //Chama o cabeçalho caso a 
   			Begin 
				if re.car>i then i:= i + 1;                                                                                 //condição tenha sido atingida
					writeln;                                                                           //(conforme a opçao de exibir)
   				x:= x + 1;
					if j>0 then
					Begin
						textcolor(lightblue);
   					writeln('Pressione qualquer tecla para próxima página');
   					textcolor(white);
   					readkey;
   				End;
   					cabeca(op);
   					j:=0;
   			End;
 			
			  if op=1 then
   			Begin
   				writeln(a:4,' ',re.num:4,' ',re.nome,' ',copy(re.data,7,2),'/',copy(re.data,5,2),'/',copy(re.data,1,4),re.car:3); 				   
    		End
    		
    		else if op=2 then
    		Begin
   				write(a:4,' ',re.num:4,' ',re.nome,' ',re.so:3,' ',re.n3:3,' ',re.n4:3,' ',re.n2:3,' ',re.n1:3,' ',
					 				copy(re.data,7,2),'/',copy(re.data,5,2),'/',copy(re.data,1,4),re.car:3);
					if (re.ccl <> 0) then writeln(' CLAS CAR=',re.ccl)	// Só vai aparecer isso se  o candidato se classificou
					else writeln; // Se não aparecer o "CLAS CAR=RE.CAR", simplesmente pula linha
    		End
    		
    		else if op=3 then
    		Begin
   				write(a:4,' ',re.num:4,' ',re.nome,' ',re.so:3,' ',re.n3:3,' ',re.n4:3,' ',re.n2:3,' ',re.n1:3,' ',
					 				copy(re.data,7,2),'/',copy(re.data,5,2),'/',copy(re.data,1,4),re.car:3);
					if (re.ccl <> 0) then writeln(' CLAS CAR=',re.ccl)	// Só vai aparecer isso se  o candidato se classificou
					else writeln; // Se não aparecer o "CLAS CAR=RE.CAR", simplesmente pula linha
    		End;
				j:=j+1;
  		End;  // Fim da exibição
  		
  		writeln;
  		textcolor(lightgreen);
			writeln('Total de registros lidos=',a:5);
			textcolor(lightblue);
			writeln;
			writeln('Pressione qualquer tecla para continuar');
			textcolor(white);
			readkey;
				    
    End;      
  End; // Fim do laço principal
  
  close(arqi);
  writeln;
  textcolor(lightred);
  writeln('Presione qualquer tecla para finalizar');
  readkey;
End.