Program Ponteiro;

const CODIGO_ACAO_INCLUIR_ALUNO = 1;
			CODIGO_ACAO_REMOVER_ALUNO = 2;
			CODIGO_ACAO_LISTAR_CURSOS = 3;
			CODIGO_ACAO_LISTAR_ALUNOS = 4;
			CODIGO_ACAO_ENCERRAR = 5;

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
			
					while (aux2^.prox <> nil) AND (nomeCurso < aux2^.nome) do
						begin;
							anterior := aux2;
							aux2 := aux2^.prox;
						end;
				  
					if (aux2 = listaCurso) AND (nomeCurso < aux2^.nome) then
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
	writeln('Qual o curso desejado?');
	readln(nomeCurso);
	solicitaNomeCurso := nomeCurso;
end; 

{
	Solicita o nome do aluno
	@return string
}
function solicitaNomeAluno():string;
var nomeAluno: string;
begin;
	clrscr;
	writeln('Qual o nome do aluno?');
	readln(nomeAluno);
	solicitaNomeAluno := nomeAluno;
end;								

{
	Insere um novo aluno
	@param nodeCurso curso
}								
procedure insereAluno(var listaCurso: nodeCurso);
var nomeCurso, nomeAluno: string;
var curso, aux, aux2, anterior: nodeCurso;
begin;	
	nomeCurso := solicitaNomeCurso();
	curso := getNodeCurso(listaCurso, nomeCurso);
	nomeAluno := solicitaNomeAluno();
	new(aux);
	
	if (aux = nil) then
		begin;
			writeln('A lista está cheia!');
		end
	else if (curso^.aluno = nil) then
		begin;
			aux^.nome := nomeAluno;
			aux^.prox := nil;
			curso^.aluno := aux;
		end
	else
		begin;
			aux^.nome := nomeAluno;
			anterior := curso^.aluno;
			aux2 := curso^.aluno;
			
			while (aux2^.prox <> nil) AND (nomeAluno > aux2^.nome) do
				begin;
					anterior := aux2;
					aux2 := aux2^.prox;
				end;
				
			if (aux2 = curso^.aluno) AND (nomeAluno < aux2^.nome) then
				begin;
					aux^.prox := curso^.aluno;
					curso^.aluno := aux;	
				end
			else if (aux2^.prox = nil) AND (nomeAluno > aux2^.nome) then 
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
		
	writeln('Fim da listagem');
	writeln('');
end; 

{
	Realiza a listagem dos alunos de determinado curso
	@param nodeCurso listaCurso
}
procedure listarAlunos(listaCurso: nodeCurso);
var nomeCurso: string;
var curso, aux: nodeCurso; 
begin;
	clrscr;
	writeln('Deseja listar os alunos de qual curso? (Digite o nome do mesmo)');
	listarCursos(listaCurso);
	readln(nomeCurso);
	curso := getNodeCurso(listaCurso, nomeCurso);
	aux := curso^.aluno;
	clrscr;
	writeln('Alunos do curso ', curso^.nome, ':');
	
	while (aux <> nil) do
		begin;
			writeln(aux^.nome);
			aux := aux^.prox;
		end;
		
	writeln('Fim da listagem');
	writeln('');
end;

{
	Remove um aluno de determinado curso
	@param nodeCurso listaCurso
}
procedure removeAluno(listaCurso:nodeCurso);
var nomeCurso, nomeAluno: string;
var curso, aux, anterior: nodeCurso;
begin

	if (listaCurso = nil) then
		writeln('O sistema não possui nenhum curso cadastrado')
	else
		begin; 
			nomeCurso := solicitaNomeCurso();
			curso := getNodeCurso(listaCurso, nomeCurso);
			nomeAluno := solicitaNomeAluno();
			anterior := curso^.aluno;
			aux := curso^.aluno;
			
		while (aux^.prox <> nil) AND (nomeAluno <> aux^.nome) do             
			begin;
				anterior := aux;
				aux := aux^.prox;
			end;
			
		if (anterior = aux) AND (aux^.nome = nomeAluno) then
			begin
				curso^.aluno := aux^.prox;
				dispose(aux);	
			end
		else if (anterior <> aux) AND (aux^.nome = nomeAluno) then
			begin
				anterior^.prox := aux^.prox;
				dispose(aux);
			end
		else
			begin;
				writeln('O aluno não está matriculado no curso');
			end;
		end;
end;

{
	Inicia o menu do sistema
}								
procedure iniciaMenu();
var op: byte;
var listaCurso: nodeCurso;
begin;
	while(op <> CODIGO_ACAO_ENCERRAR) do
		begin;
			writeln ('    MENU    ');
			writeln ('------------');
			writeln (CODIGO_ACAO_INCLUIR_ALUNO, ' - Inserir Aluno');
			writeln (CODIGO_ACAO_REMOVER_ALUNO, ' - Remover Aluno');
			writeln (CODIGO_ACAO_LISTAR_CURSOS, ' - Listar Cursos');
			writeln (CODIGO_ACAO_LISTAR_ALUNOS, ' - Listar Alunos');
			writeln (CODIGO_ACAO_ENCERRAR		  , ' - Finalizar');
			readln(op);
			clrscr;
			
			if (op = CODIGO_ACAO_INCLUIR_ALUNO) then
					insereAluno(listaCurso)
			else if (op = CODIGO_ACAO_LISTAR_CURSOS) then
				  listarCursos(listaCurso)
			else if (op = CODIGO_ACAO_LISTAR_ALUNOS) then
				  listarAlunos(listaCurso)
			else if (op = CODIGO_ACAO_REMOVER_ALUNO) then
					removeAluno(listaCurso);
		end;
end;

Begin
	iniciaMenu();	  
End.