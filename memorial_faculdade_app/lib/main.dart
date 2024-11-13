import 'package:flutter/material.dart';
import 'screens/alunos_screen.dart';
import 'screens/professores_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorial Faculdade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlunosScreen(),
      routes: {
        '/alunos': (context) => AlunosScreen(),
        '/professores': (context) => ProfessoresScreen(),
      },
    );
  }
}
