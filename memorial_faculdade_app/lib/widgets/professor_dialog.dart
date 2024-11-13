import 'package:flutter/material.dart';

class ProfessorDialog extends StatefulWidget {
  @override
  _ProfessorDialogState createState() => _ProfessorDialogState();
}

class _ProfessorDialogState extends State<ProfessorDialog> {
  final _nomeController = TextEditingController();
  final _disciplinaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Professor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nomeController,
            decoration: InputDecoration(labelText: 'Nome'),
          ),
          TextField(
            controller: _disciplinaController,
            decoration: InputDecoration(labelText: 'Disciplina'),
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
            final professor = {
              'nome': _nomeController.text,
              'disciplina': _disciplinaController.text,
            };
            Navigator.of(context).pop(professor);  // Retorna os dados para a tela principal
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
