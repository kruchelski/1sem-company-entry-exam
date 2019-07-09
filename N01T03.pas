Program N01T03 ; {Cassiano Kruchelski Vidal e Gustavo de Oliveira Achinitz}
uses MODULOS;

var	re:regis;
		arqi:file of regis;
		ind:vetor;
		a, len, op, e, pag, t:integer;
		opaux:string[1];
		ord:string[15];
		staux:string[4];

Procedure cabeca();
Begin
  clrscr ;
  pag := pag+1;
  textcolor(lightgreen);
  writeln('                         RELATORIO GERAL - ORDEM ',ord,'              PAGINA:',pag:3);
  writeln;
  write('  ORD  NUM N O M E                              ===C P F=== NASCIMENTO CS  N1');
  writeln('  N2  N3  N4  SO  CG CC CV');
  textcolor(white);
End;

Begin
	textcolor(white);
  assign(arqi,'cand.ind');
  reset(arqi);
  while(op<>5) do
  Begin // O programa foi colocado dentro de um laço para o caso do usuário querer ver em outra forma de ordenção após o fim de uma visualização.
    //============================== "menu principal" =============================================================
    clrscr;
    writeln('========================= ENLATADOS ========================');
    writeln('=                                                          =');
    writeln('=      Visualização dos registros de forma ordenada        =');
    writeln('=                                                          =');
    writeln('= ---------------------------------------------------------=');
    writeln;
    writeln('Digite a opção correspondente a forma de ordenação desejada:');
    writeln('1) Por NÚMERO DE INSCRIÇÃO');
    writeln('2) Por NOME');
    writeln('3) Por CPF');
    writeln('4) Por DATA DE NASCIMENTO');
    writeln('------------------------------------------------------------');
    writeln('5) Encerra o programa...');
    writeln;
    repeat  // Validar a opção lida
      write('Opção: ');
      readln(opaux);
      val(opaux,op,e);
      if(e<>0) then writeln('Opção contém erro de digitação. Digite novamente')
      else if(op<1)or(op>5) then writeln('Opção inválida. Digite uma opção dentre as disponíveis');
      writeln;
    until((e=0)and((op>0)and(op<6)));
    
    if (op=5) then  // Caso seja selecionada a opção para encerrar o programa, aparecerá uma mensagem informando o encerramento
    Begin
      write('Encerrando');delay(100);write('.');delay(100);write('.');delay(100);writeln('.');delay(100);
    End
    else  // Aqui inicia a leitura do arquivo para preencher o índice
    Begin
      a:=1;
      while not(eof(arqi)) do
      Begin
      	seek(arqi,a-1);
        read(arqi,re);
        ind[a].pf:=a-1;
        if (op=1) then
        Begin  
          str(re.num,staux);
          len:=length(staux);
          for t:=1 to 4-len do insert('0',staux,1);
          ind[a].c_chave:=staux;
        End
        else if (op=2) then ind[a].c_chave := re.nome
        else if (op=3) then ind[a].c_chave := re.cpf
        else if (op=4) then ind[a].c_chave := re.data;
        a:=a+1;
      End;
        
      writeln;
      textcolor(lightred);
      writeln('Ordenando...');
      textcolor(white);
      ordem(ind,a-1); // Ordenação
     
      if (op=1) then ord:='NÚMERO'
      else if (op=2) then ord:='NOME'
      else if (op=3) then ord:= 'CPF'
      else if (op=4) then ord:= 'DATA';
      
      clrscr;
 			cabeca();
 			for t:=1 to a-1 do
 			Begin
 				seek(arqi,ind[t].pf);
   			read(arqi,re);
   			writeln(t:5,re.num:5,' ',re.nome,' ',re.cpf,' ',copy(re.data,7,2),'/',copy(re.data,5,2),'/',copy(re.data,1,4),
				 				re.car:3,re.n1:4,re.n2:4,re.n3:4,re.n4:4,re.so:4,re.clg:4,re.clc:3,re.ccl:3 );				   
    		if(t mod 40 = 0) then
     		Begin
     			writeln;
     			textcolor(lightblue);
     			writeln('Pressione qualquer tecla para a próxima página');
     			textcolor(white);
       		readkey;
       		cabeca();
     		End;
  		end;
  		writeln;
  		textcolor(lightgreen);
			writeln('Total de registros lidos=',t:5);
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