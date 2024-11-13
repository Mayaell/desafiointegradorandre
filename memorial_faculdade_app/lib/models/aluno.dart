class Aluno {
  final String nome;
  final int idade;
  final int quantidadeTrabalhos;
  final String curso; // Aqui o curso pode ser nulo

  Aluno({
    required this.nome,
    required this.idade,
    required this.quantidadeTrabalhos,
    required this.curso,
  });

  // Construtor a partir do JSON
  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      nome: json['nome'] ?? 'Sem Nome',  // Garantir valor padrão para nome
      idade: json['idade'] ?? 0,
      quantidadeTrabalhos: json['quantidade_trabalhos'] ?? 0,
      curso: json['curso'] ?? 'Sem Curso',  // Garantir valor padrão para curso
    );
  }

  // Método para converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idade': idade,
      'quantidade_trabalhos': quantidadeTrabalhos,
      'curso': curso,
    };
  }
}
