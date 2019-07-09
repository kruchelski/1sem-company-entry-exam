Program N01T02 ; {Cassiano Kruchelski Vidal e Gustavo de Oliveira Achinitz}
uses MODULOS;
	var arqt:text;
			arqi:file of regis;
			i,e:integer;
			st:string[60];
			reg:regis;
			
Begin
	assign(arqt,'cand.txt');
	assign(arqi,'cand.ind');
	reset(arqt);
	rewrite(arqi);
	while not(eof(arqt)) do
		Begin                                                                   
			readln(arqt,st);
			val(copy(st,1,4),reg.num,e);
			reg.nome:=copy(st,5,36);
			reg.cpf:=copy(st,41,11);
			reg.data:=copy(st,56,4) + copy(st,54,2) + copy(st,52,2);
			val(copy(st,60,1),reg.car,e);
			seek(arqi,i);
			write(arqi,reg);
			i:=i+1;		
		End;
	close(arqt);
	close(arqi);
	writeln('Arquivo cand.ind criado');
	writeln('Pressione qualquer tecla para encerrar');
	readkey;
		
  
End.