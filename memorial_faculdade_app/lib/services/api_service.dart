import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:memorial_faculdade_app/models/aluno.dart';
import 'package:memorial_faculdade_app/models/professor.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000'; // URL do seu servidor backend

  // Função para obter todos os alunos
  Future<List<Aluno>> fetchAlunos() async {
    final response = await http.get(Uri.parse('$baseUrl/alunos'));

    if (response.statusCode == 200) {
      final List<dynamic> alunoJson = json.decode(response.body);
      return alunoJson.map((json) => Aluno.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar alunos');
    }
  }

  // Função para adicionar um aluno com o campo "curso"
Future<bool> adicionarAluno(String nome, int idade, int quantidadeTrabalhos, String curso) async {
  final response = await http.post(
    Uri.parse('$baseUrl/add-aluno'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'nome': nome,
      'idade': idade,
      'quantidade_trabalhos': quantidadeTrabalhos,
      'curso': curso.isEmpty ? 'Sem Curso' : curso,  // Se curso estiver vazio, atribui 'Sem Curso'
    }),
  );

  return response.statusCode == 200;
}


  // Função para obter todos os professores
  Future<List<Professor>> fetchProfessores() async {
    final response = await http.get(Uri.parse('$baseUrl/professores'));

    if (response.statusCode == 200) {
      final List<dynamic> professorJson = json.decode(response.body);
      return professorJson.map((json) => Professor.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar professores');
    }
  }

  // Função para adicionar um professor com o campo "curso"
// Atualização do método para incluir o campo curso
Future<bool> adicionarProfessor(String nome, int quantidadeTrabalhos, String curso) async {
  final response = await http.post(
    Uri.parse('$baseUrl/add-professor'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'nome': nome,
      'quantidade_trabalhos': quantidadeTrabalhos,
      'curso': curso, // Incluindo o curso
    }),
  );

  return response.statusCode == 200;
}


}
