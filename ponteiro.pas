Program Ponteiro;

const CODIGO_ACAO_INCLUIR = 1;
			CODIGO_ACAO_LISTAR_CURSOS = 2;

type 	nodeAluno = ^TAluno;
			TAluno = record
									nome: string;
									prox: nodeAluno;
								end;
			nodeCurso = ^TCurso;
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
procedure insereNovoCurso(var listaCurso: nodeCurso; nomeCurso: string);
var aux, aux2, anterior: nodeCurso;
begin;
	new(aux);
	
	if (aux = nil) then
		writeln('A lista está cheia')
	else
		begin;
			aux^.nome := nomeCurso;
			
			if (listaCurso = nil) then
				begin;
					aux^.prox := nil;
					listaCurso := aux;
				end
			else 
				begin;
					anterior := listaCurso;
					aux2 := listaCurso;
			
					while (aux2^.prox <> nil) AND (nomeCurso > aux2^.nome) do
						begin;
							anterior := aux2;
							aux2 := aux2^.prox;
						end;
				
					if (aux2 = listaCurso) then
						begin;
							aux^.prox := listaCurso;
							listaCurso := aux;	
						end
					else if (aux2^.prox = nil) AND (nomeCurso > aux2^.nome) then 
						begin;
							aux^.prox := nil;
					  	aux2^.prox := aux;		
						end
					else 
						begin;
							anterior^.prox := aux;
							aux^.prox := aux2;	
						end;
				end;
		end;
end;

								
{
	Busca o nó de determinado curso
	@param nodeCurso
	@param string nomeCurso
}
function getNodeCurso(var listaCurso: nodeCurso; nomeCurso: string): nodeCurso;
var aux: nodeCurso;
begin;
	if (listaCurso = nil) then
		begin;
			insereNovoCurso(listaCurso, nomeCurso);
			getNodeCurso := getNodeCurso(listaCurso, nomeCurso);
		end
	else
		begin;
			aux := listaCurso;
			
			while (aux <> nil) AND (aux^.nome <> nomeCurso) do
				begin;
					aux := aux^.prox;
				end;
				
			if (aux^.nome = nomeCurso) then
				getNodeCurso := aux
			else
				begin;
					insereNovoCurso(listaCurso, nomeCurso);
					getNodeCurso := getNodeCurso(listaCurso, nomeCurso);	
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
	solicitaNomeCurso := nomeCurso;
end; 								

{
	Insere um novo aluno
	@param nodeCurso curso
}								
procedure insereAluno(var listaCurso: nodeCurso);
var nomeCurso, nomeAluno: string;
var curso: nodeCurso;
begin;	
	nomeCurso := solicitaNomeCurso();
	curso := getNodeCurso(listaCurso, nomeCurso);
end;

{
	Realiza a listagem dos cursos
	@param nodeCurso listaCurso
}
procedure listarCursos(listaCurso: nodeCurso);
var aux: nodeCurso;
var index: integer;
begin;
	index := 1;
	aux := listaCurso;
	writeln('Lista de Cursos');
	
	while (aux <> nil) do
		begin;
			writeln(index, ' - ', aux^.nome);
			aux := aux^.prox;
			index := index + 1;
		end;
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
			writeln (CODIGO_ACAO_LISTAR_CURSOS, ' - Listar Cursos');
			writeln ('3 - Finalizar');
			readln(op);
			clrscr;
			
			if (op = CODIGO_ACAO_INCLUIR) then
				begin; 
					insereAluno(listaCurso);	
				end
			else if (op = CODIGO_ACAO_LISTAR_CURSOS) then
				  listarCursos(listaCurso);
		end;
end;

Begin
	iniciaMenu();	  
End.