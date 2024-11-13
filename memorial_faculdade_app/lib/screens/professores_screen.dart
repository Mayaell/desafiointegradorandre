import 'package:flutter/material.dart';
import 'package:memorial_faculdade_app/models/professor.dart';
import 'package:memorial_faculdade_app/services/api_service.dart';
import 'alunos_screen.dart'; // Para navegar entre as telas

class ProfessoresScreen extends StatefulWidget {
  @override
  _ProfessoresScreenState createState() => _ProfessoresScreenState();
}

class _ProfessoresScreenState extends State<ProfessoresScreen> {
  late Future<List<Professor>> professores;

  // Controllers para capturar os dados do formulário
  final _nomeController = TextEditingController();
  final _quantidadeTrabalhosController = TextEditingController();
  final _cursoController =
      TextEditingController(); // Novo controlador para o curso

  @override
  void initState() {
    super.initState();
    professores =
        ApiService().fetchProfessores(); // Carregar professores ao inicializar
  }

  // Função para adicionar um professor
  void _adicionarProfessor() async {
    final nome = _nomeController.text;
    final quantidadeTrabalhos =
        int.tryParse(_quantidadeTrabalhosController.text) ?? 0;
    final curso = _cursoController.text; // Obtém o valor do campo curso

    // Verifica se os campos obrigatórios estão preenchidos
    if (nome.isEmpty || quantidadeTrabalhos == 0 || curso.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Por favor, preencha todos os campos corretamente!')),
      );
      return;
    }

    // Chama o serviço para adicionar o professor
    final sucesso =
        await ApiService().adicionarProfessor(nome, quantidadeTrabalhos, curso);

    if (sucesso) {
      // Atualiza a lista de professores
      setState(() {
        professores = ApiService().fetchProfessores();
      });

      // Limpa os campos do formulário
      _nomeController.clear();
      _quantidadeTrabalhosController.clear();
      _cursoController.clear(); // Limpa o campo curso

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Professor adicionado com sucesso!')),
      );
    } else {
      // Exibe uma mensagem de erro se a adição falhar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar professor!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professores'),
      ),
      body: Column(
        children: [
          // Formulário para adicionar professores
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome do Professor'),
                ),
                TextField(
                  controller: _quantidadeTrabalhosController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Quantidade de Trabalhos'),
                ),
                TextField(
                  controller: _cursoController, // Campo para o curso
                  decoration: InputDecoration(labelText: 'Curso'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _adicionarProfessor,
                  child: Text('Adicionar Professor'),
                ),
              ],
            ),
          ),

          // Exibição da lista de professores
          Expanded(
            child: FutureBuilder<List<Professor>>(
              future: professores,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum professor encontrado'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var professor = snapshot.data![index];
                      final nomeProfessor =
                          professor.nome.isEmpty ? 'Sem Nome' : professor.nome;
                      final cursoProfessor = professor.curso.isEmpty
                          ? 'Sem Curso'
                          : professor.curso;

                      return ListTile(
                        title: Text(nomeProfessor),
                        subtitle: Text(
                          'Trabalhos: ${professor.quantidadeTrabalhos} - Curso: $cursoProfessor',
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
                    AlunosScreen()), // Navegar para tela de alunos
          );
        },
        child: Icon(Icons.school),
        tooltip: 'Ir para Alunos',
      ),
    );
  }
}
