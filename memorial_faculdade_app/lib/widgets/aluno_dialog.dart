import 'package:flutter/material.dart';

class AlunoDialog extends StatefulWidget {
  @override
  _AlunoDialogState createState() => _AlunoDialogState();
}

class _AlunoDialogState extends State<AlunoDialog> {
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _trabalhosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Aluno'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: _idadeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Idade'),
          ),
          TextField(
            controller: _trabalhosController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Trabalhos Feitos'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Fecha o diálogo
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            final aluno = {
              'nome': _nomeController.text,
              'idade': int.parse(_idadeController.text),
              'trabalhos': int.parse(_trabalhosController.text),
            };
            Navigator.of(context).pop(aluno);  // Retorna os dados para a tela principal
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
