import 'package:flutter/material.dart';
import 'package:memorial_faculdade_app/models/aluno.dart';
import 'package:memorial_faculdade_app/services/api_service.dart';
import 'professores_screen.dart'; // Para navegar entre as telas

class AlunosScreen extends StatefulWidget {
  @override
  _AlunosScreenState createState() => _AlunosScreenState();
}

class _AlunosScreenState extends State<AlunosScreen> {
  late Future<List<Aluno>> alunos;

  // Variáveis para armazenar os dados do formulário
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _quantidadeTrabalhosController = TextEditingController();
  final _cursoController = TextEditingController(); // Campo para curso

  @override
  void initState() {
    super.initState();
    alunos = ApiService().fetchAlunos(); // Carregar alunos ao inicializar
  }

  // Função para adicionar um novo aluno
  void _adicionarAluno() async {
    final nome = _nomeController.text;
    final idade = int.tryParse(_idadeController.text) ?? 0;
    final quantidadeTrabalhos =
        int.tryParse(_quantidadeTrabalhosController.text) ?? 0;
    final curso = _cursoController.text;

    // Verificar se os campos estão preenchidos corretamente
    if (nome.isEmpty ||
        idade == 0 ||
        quantidadeTrabalhos == 0 ||
        curso.isEmpty) {
      // Exibe uma mensagem de erro se algum campo estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos corretamente!')),
      );
      return;
    }

    // Chama o serviço para adicionar o aluno
    final sucesso = await ApiService()
        .adicionarAluno(nome, idade, quantidadeTrabalhos, curso);

    if (sucesso) {
      // Atualiza a lista de alunos
      setState(() {
        alunos = ApiService().fetchAlunos();
      });

      // Limpa os campos do formulário
      _nomeController.clear();
      _idadeController.clear();
      _quantidadeTrabalhosController.clear();
      _cursoController.clear(); // Limpa o campo curso

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Aluno adicionado com sucesso!')),
      );
    } else {
      // Exibe uma mensagem de erro se a adição falhar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar aluno!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alunos'),
      ),
      body: Column(
        children: [
          // Formulário para adicionar alunos
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome do Aluno'),
                ),
                TextField(
                  controller: _idadeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Idade do Aluno'),
                ),
                TextField(
                  controller: _quantidadeTrabalhosController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Quantidade de Trabalhos'),
                ),
                TextField(
                  controller: _cursoController, // Campo para curso
                  decoration: InputDecoration(labelText: 'Curso do Aluno'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _adicionarAluno,
                  child: Text('Adicionar Aluno'),
                ),
              ],
            ),
          ),

          // Exibição da lista de alunos
          Expanded(
            child: FutureBuilder<List<Aluno>>(
              future: alunos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum aluno encontrado'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var aluno = snapshot.data![index];
                      return ListTile(
                        title: Text(aluno.nome),
                        subtitle: Text(
  'Idade: ${aluno.idade} - '
  'Trabalhos: ${aluno.quantidadeTrabalhos} - '
  'Curso: ${aluno.curso}', // O campo curso já vem com valor padrão caso seja nulo
),

                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfessoresScreen()), // Navegar para tela de professores
          );
        },
        child: Icon(Icons.person_add),
        tooltip: 'Ir para Professores',
      ),
    );
  }
}
