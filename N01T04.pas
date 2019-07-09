Program N01T04 ; // Cassiano Kruchelski Vidal e Gustado de Oliveira Achinitz
uses MODULOS;

var re:regis;
		ind:vetor;
		arqi: file of regis;
		prova: text;
		regprova: string[54];
		gab:string[50];
		a, len, op, e, pag, t, x, tot:integer;
		soma1, soma2:real;
		opaux: string[1];
		staux: string[4];
		branco1, branco2, errado1, errado2:array[1..2000] of integer;
		dis1,dis2:string[11];

Procedure cabecalho();

Begin
  clrscr ;
  pag := pag+1;
  textcolor(lightgreen);                                                         //
  writeln('          RELATORIO CORREÇÃO - ORDEM INCRIÇÃO          PAGINA: ',pag:3);
  writeln;
  writeln('                                          ',dis1,'     ',dis2);                                          
  writeln(' NUM N O M E                              CE ER BR NOT   CE ER BR NOT ');
  textcolor(white);
End;


Begin
	textcolor(lightred);
	writeln('Carregando...');
	textcolor(lightgreen);
  assign(arqi,'CAND.IND');
  reset(arqi);
  a:=1;
  while not(eof(arqi)) do     										//Carrega o índice
  Begin
    seek(arqi,a-1);
    read(arqi,re);
    ind[a].pf:=a-1;
    str(re.num,staux);
    len:=length(staux);
    for t:=1 to 4-len do insert('0',staux,1);
    ind[a].c_chave:=staux;
    a:=a+1;
  End;
  t:=a-1;
  
  ordem(ind,t); 															// Ordena o índice
  
  repeat //Laço do programa
  	soma1:=0;
  	soma2:=0;
    clrscr;
    writeln('========================= ENLATADOS ========================');
    writeln('=                                                          =');
    writeln('=                    Correção das provas                   =');
    writeln('=                                                          =');
    writeln('= ---------------------------------------------------------=');
    writeln;
    textcolor(white);
    writeln('Digite a opção correspondente a prova que deseja corrigir:');
    writeln('1) PROVA 1');
    writeln('2) PROVA 2');
    writeln('------------------------------------------------------------');
    writeln('0) Encerra o programa...');
    writeln;
    pag:=0;
    repeat
      write('Opção: ');
      readln(opaux);
      writeln;
      val(opaux,op,e);
      if (e<>0) then writeln('Opção contém caractere inválido. Digite novamente')
      else if ((op<0)or(op>2)) then writeln('Opção inválida. Digite novamente');
      writeln;
    until (e=0)and((op>-1)and(op<3));
    
    if(op=0) then
    Begin
      textcolor(lightred);
      write('Encerrando o programa');delay(100);write('.');delay(100);write('.');delay(100);write('.');delay(100);
      textcolor(white);
    End
    else
    Begin
      if op=1 then   //Inserir gabarito da prova 1
      Begin
        assign(prova,'prova1.txt');
        clrscr;
        textcolor(lightblue);
        writeln('A PROVA 1 SERÁ CORRIGIDA...');
        textcolor(lightgreen);
        writeln;
        writeln('A PROVA 1 é composta de 25 questões de português e 25 questões de matemática');
        writeln('----------------------------------------------------------------------------');
        writeln('Questões 1 a 25 : Português');
        writeln('Questoes 26 a 50 : Matemática');
        writeln;
        writeln('Digite o gabarito das 25 questões de português');
        writeln('Atenção: Respostas possíveis - A, B, C, D, E)');
        writeln;
        textcolor(lightblue);
        writeln('Pressione QUALQUER TECLA para continuar');
        readkey;
        textcolor(lightgreen);
        clrscr;
        writeln('----- PORTUGUÊS (1 a 25) -----');
        textcolor(white);
        for a:=1 to 25 do
        Begin
          repeat
            write('Questão ',a:2,': ');
            readln(gab[a]);
            gab[a]:=upcase(gab[a]);
              if (gab[a]<#65) or (gab[a]>#69) then
              Begin
                textcolor(lightred);
                writeln('Opção inválida. Digite novamente (A, B, C, D, ou E');
                textcolor(white);
                writeln;
              End;
          until (gab[a]>#64)and(gab[a]<#70);  // Verificação se o que foi digitado no gabarito está correto (Apenas letras a, b, c, d ou e);
        End;
        writeln;
        textcolor(lightblue);
        writeln('Gabarito de PORTUGUÊS OK!');
        writeln;
        writeln('Pressione QUALQUER TECLA para iniciar a inserção do gabarito de MATEMÁTICA');
        readkey;
        textcolor(lightgreen);
        writeln('----- MATEMÁTICA (26 a 50) -----');
        textcolor(white);
        for a:=26 to 50 do
        Begin
          repeat
            write('Questão ',a:2,': ');
            readln(gab[a]);
            gab[a]:=upcase(gab[a]);
            if (gab[a]<#65) or (gab[a]>#69) then
        	  Begin
          	  textcolor(lightred);
              writeln('Opção inválida. Digite novamente (A, B, C, D, ou E');
              textcolor(white);
              writeln;
            End;
          until (gab[a]>#64)and(gab[a]<#70);  // Verificação se o que foi digitado no gabarito está correto (Apenas letras a, b, c, d ou e);
        End;
        writeln;
        textcolor(lightblue);
        writeln('Gabarito de MATEMÁTICA OK!');
        writeln;
        writeln('Pressione QUALQUER TECLA para mostrar os resultados');
        readkey;
      End     // FIM DA INSERÇÃO DO GABARITO PAR A PROVA 1
      //------------------------------------------------------------------------------------
     // Inserir gabarito da prova 2
      else if op=2 then
      Begin
     		assign(prova,'prova2.txt');
        clrscr;
        textcolor(lightblue);
        writeln('A PROVA 2 SERÁ CORRIGIDA...');
        textcolor(lightgreen);
        writeln;
        writeln('A PROVA 2 é composta de 25 questões de conhecimentos especificos e 25 questões de informática');
        writeln('---------------------------------------------------------------------------------------------');
        writeln('Questões 1 a 25 : Conhecimentos específicos');
        writeln('Questoes 26 a 50 : Informática');
        writeln;
        writeln('Digite o gabarito das 25 questões de conhecimentos específicos');
        writeln('Atenção: Respostas possíveis - A, B, C, D, E');
        writeln;
        textcolor(lightblue);
        writeln('Pressione QUALQUER TECLA para continuar');
        readkey;
        textcolor(lightgreen);
        clrscr;
        writeln('----- CONHECIMENTOS ESPECÍFICOS (1 a 25) -----');
        textcolor(white);
        for a:=1 to 25 do
        Begin
        	repeat
          	write('Questão ',a:2,': ');
            readln(gab[a]);
            gab[a]:=upcase(gab[a]);
          	if (gab[a]<#65) or (gab[a]>#69) then
            Begin
            	textcolor(lightred);
              writeln('Opção inválida. Digite novamente (A, B, C, D, ou E');
              textcolor(white);
              writeln;
            End;
          until (gab[a]>#64)and(gab[a]<#70);  // Verificação se o que foi digitado no gabarito está correto (Apenas letras a, b, c, d ou e);
        End;
        writeln;
        textcolor(lightblue);
        writeln('Gabarito de CONHECIMENTOS ESPECÍFICOS OK!');
        writeln;
        writeln('Pressione QUALQUER TECLA para iniciar a inserção do gabarito de INFORMÁTICA');
        readkey;
        textcolor(lightgreen);
        writeln('----- INFORMÁTICA (26 a 50) -----');
        textcolor(white);
        for a:=26 to 50 do
        Begin
        	repeat
          	write('Questão ',a:2,': ');
            readln(gab[a]);
            gab[a]:=upcase(gab[a]);
            if (gab[a]<#65) or (gab[a]>#69) then
            Begin
            	textcolor(lightred);
              writeln('Opção inválida. Digite novamente (A, B, C, D, ou E');
              textcolor(white);
              writeln;
            End;
          until (gab[a]>#64)and(gab[a]<#70);  // Verificação se o que foi digitado no gabarito está correto (Apenas letras a, b, c, d ou e);
        End;
        writeln;
        textcolor(lightblue);
        writeln('Gabarito de INFORMÁTICA OK!');
        writeln;
        writeln('Pressione QUALQUER TECLA para mostrar os resultados');
        readkey;
      End; //Fim dos if/else de inserção de gabarito
              
      //Cálculos do programa para veriricar erros e acertos de cada candidato.--------------------------------------------------
      tot:=0;
			reset(prova);        
      while not(eof(prova)) do
      Begin
      	readln(prova,regprova);
                
        pebin1(ind,copy(regprova,1,4),t,x); //Localiza a posição do candidato
                
        if (x=0) then
        Begin
        	textcolor(lightred);
          writeln;
          writeln('CANDIDATO Nº',copy(regprova,1,4),' NÃO ENCONTRADO');
          textcolor(white);
        End
        else
        Begin
        	seek(arqi,ind[x].pf); //Posiciona no cand.ind conforme a posição localizada.
          read(arqi,re);
          if op=1 then
          Begin
						re.n1:=0;
          	re.n2:=0;
          End
          Else
          Begin
						re.n3:=0;
          	re.n4:=0;
          End;
					errado1[ind[x].pf+1]:=0;
          branco1[ind[x].pf+1]:=0;
					errado2[ind[x].pf+1]:=0;
          branco2[ind[x].pf+1]:=0;
          for a:=1 to 25 do           //Corrigindo primeiro as questões de 1 a 25
          Begin
          	if (regprova[a+4]=gab[a]) then     //Caso de acerto
            Begin
            	if op=1 then re.n1:=re.n1+4      //Conforme a prova que está sendo corrigida, irá atualizar o campo correto da nota
							else if op=2 then re.n3:=re.n3+4;
						End
            else if (regprova[a+4]=' ') then branco1[ind[x].pf+1]:=branco1[ind[x].pf+1]+1
            else if (regprova[a+4]<>'*') then errado1[ind[x].pf+1]:=errado1[ind[x].pf+1]+1;
          End;
          for a:=26 to 50 do          //Corrigindo então as questões de 26 a 50
          Begin
          	if (regprova[a+4]=gab[a]) then   //Caso de acerto
            Begin
            	if op=1 then re.n2:=re.n2 + 4
							else if op=2 then re.n4:=re.n4 + 4; 
						End
            else if (regprova[a+4]=' ') then branco2[ind[x].pf+1]:=branco2[ind[x].pf+1]+1
            else if (regprova[a+4]<>'*') then errado2[ind[x].pf+1]:=errado2[ind[x].pf+1]+1;
          End;
          tot:=tot+1;
          if op=1 then
          Begin
          	soma1:=soma1 + re.n1;
          	soma2:=soma2 + re.n2;
          End
          Else
          Begin
          	soma1:=soma1 + re.n3;
          	soma2:=soma2 + re.n4;
					End;
					if op=2 then re.so:= re.n1 + re.n2 + re.n3 + re.n4; //atualiza o campo soma após corrigir a segunda prova
					seek(arqi,ind[x].pf);
					write(arqi,re);
				End;	      
      End; //fim do laço de leitura do arquivo prova---------------------------------------------------------------------------------
      close(prova);

			if (op=1) then
			Begin
				dis1:=' PORTUGUÊS';
				dis2:='MATEMÁTICA';
			End
			else
			Begin
				dis1:='ESPECIFICO';
				dis2:='INFORMÁTICA';
			End;	
	
			cabecalho();    //inicio exibição do resultado---------------------------------------------------------------------------------------
 			for a:=1 to t do
 			Begin
 				seek(arqi,ind[a].pf);
   			read(arqi,re);
   			write(re.num:4,' ',re.nome,' ');
			  
			  //----Colunas da primeira matéria-----
				if (op=1) then write((re.n1 div 4):2,' ')   //Como cada acerto vale 4 pontos, logo o número de acertos é a nota total dividido por 4
				else write((re.n3 div 4):2,' ');
			
				write(errado1[ind[a].pf+1]:2,' ',branco1[ind[a].pf+1]:2,' ');  //corrigir branco e errado!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			
				if (op=1) then write(re.n1:3,'   ')
				else write (re.n3:3,'   ');				
			
				if (op=1) then write((re.n2 div 4):2,' ')
				else write((re.n4 div 4):2,' ');
			
				write(errado2[ind[a].pf+1]:2,' ',branco2[ind[a].pf+1]:2,' ');  //corrigir branco e errado!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
			
				if (op=1) then writeln(re.n2:3,'   ')
				else writeln (re.n4:3,'   ');
		   
    		if(a mod 40 = 0) then
    		Begin
    			writeln;
    			textcolor(lightblue);
    			writeln('Pressione qualquer tecla para a próxima página');
    			textcolor(white);
     			readkey;
     			cabecalho();
    		End;
  		End;
  		
  		writeln;
  		textcolor(lightgreen);
  		writeln('TOTAL DE ALUNOS: ',tot);
  		writeln;
			writeln('MEDIA ',dis1,' === ',(soma1/tot):5:2);         
			writeln;
			writeln('MEDIA ',dis2,' === ',(soma2/tot):5:2);
			writeln;
			textcolor(lightblue);
			writeln;
			writeln('Pressione qualquer tecla para continuar');
			textcolor(white);
			readkey;
  	End; //Fim do laço das correções de provas		      
	until (op=0);
  writeln;
  textcolor(blue);
  writeln('Pressione QUALQUER TECLA para finalizar');
  readkey;
  close(arqi);
        
End.