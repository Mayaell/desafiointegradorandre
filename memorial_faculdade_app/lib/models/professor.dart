class Professor {
  final String nome;
  final int quantidadeTrabalhos;
  final String curso; // Novo campo para o curso

  Professor({
    required this.nome,
    required this.quantidadeTrabalhos,
    required this.curso,
  });

  // Método para converter JSON em um objeto Professor
  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      nome: json['nome'] ?? 'Sem Nome', // Tratar valores nulos
      quantidadeTrabalhos: json['quantidade_trabalhos'] ?? 0,
      curso: json['curso'] ?? 'Sem Curso', // Tratar valores nulos
    );
  }

  // Método para converter um objeto Professor em um mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'quantidade_trabalhos': quantidadeTrabalhos,
      'curso': curso,
    };
  }
}

