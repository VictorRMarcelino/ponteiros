Program Ponteiro;

const CODIGO_ACAO_INCLUIR = 1;

type 	nodeAluno = ^TAluno;
			TAluno = record
									nome: string;
									prox: nodeAluno;
								end;
			nodeCurso = TCurso;
			TCurso = record
									nome: string;
									aluno: nodeAluno;
									prox: nodeCurso;			

								end;

{
	Realiza a inclusão de um novo curso
	@param nodeCurso listaCurso
	@param string nomeCurso
}
procedure insereNovoCurso(listaCurso: nodeCurso, nomeCurso: string);
var aux, aux2, anterior: nodeCurso;
begin;
	if (listaCurso = nil) then
		begin;
			aux^.nome := nomeCurso;
			aux^.prox := nil;
			listaCurso := aux;
		end
	else 
		begin;
			aux2 := listaCurso;
			anterior := listaCurso;
			
			while (aux2^.prox <> nil) AND (nomeCurso > aux2^.nome) do
				begin;
					anterior := aux2;
					aux2 := aux2^.prox;
				end;
				
			if (aux2 = listaCurso) then
				begin;
					aux^.nome := nomeCurso;
				end
			else 
				begin;
					
				end;
		end;
end;

								
{
	Busca o nó de determinado curso
	@param nodeCurso
	@param string nomeCurso
}
function getNodeCurso(curso: nodeCurso; nomeCurso: string): nodeCurso;
var aux: nodeCurso;
begin;
	if (curso = nil) then
		begin;
			insereNovoCurso(curso: nodeCurso; nomeCurso: string);
			getNodeCurso := getNodeCurso();
		end
	else
		begin;
			aux := curso;
			
			while (aux^.prox <> nil) AND (aux^.nome <> nomeCurso) do
				begin;
					aux := aux^.prox;
				end;	
		end;
end;

{
	Solicita o nome do curso
	@return string
}
function solicitaNomeCurso():string;
var nomeCurso: string;
begin;
	clrscr;
	writeln('Para qual curso você deseja inserir o aluno?');
	readln(nomeCurso);
	solicitaNomeCurso := LowerCase(nomeCurso);
end;

procedure 								

{
	Insere um novo aluno
	@param nodeCurso curso
}								
procedure insereAluno(listaCurso: nodeCurso);
var nomeCurso, nomeAluno: string;
var curso: nodeCurso;
begin;	
	nomeCurso := solicitaNomeCurso();
	curso := getNodeCurso(curso, nomeCurso);
end;

{
	Inicia o menu do sistema
}								
procedure iniciaMenu();
var op: byte;
var listaCurso: nodeCurso;
begin;
	while(op <> 3) do
		begin;
			writeln ('    MENU    ');
			writeln ('------------');
			writeln (CODIGO_ACAO_INCLUIR, ' - Inserir Aluno');
			writeln ('3 - Finalizar');
			readln(opcao);
			clrscr;
			
			if (opcao = CODIGO_ACAO_INCLUIR) then
				begin; 
					inserirAluno(listaCurso);
					clrscr;	
				end
		end;
end;

Begin
	iniciaMenu();	  
End.