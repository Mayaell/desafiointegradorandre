const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());
app.use(express.json()); 

const db = new sqlite3.Database('./banco.sqlite', (err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados SQLite: ' + err.message);
    return;
  }
  console.log('Conectado ao banco de dados SQLite');
});

// Criar as tabelas caso não existam (caso contrário, você pode pular isso se já tiver as tabelas criadas no banco SQLite)
db.serialize(() => {
  db.run('CREATE TABLE IF NOT EXISTS alunos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, idade INTEGER, quantidade_trabalhos INTEGER, curso TEXT)');
  db.run('CREATE TABLE IF NOT EXISTS professores (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, quantidade_trabalhos INTEGER, curso TEXT)');
});

// Endpoint para adicionar aluno
app.post('/add-aluno', (req, res) => {
  const { nome, idade, quantidade_trabalhos, curso } = req.body;

  console.log('Recebido curso:', curso); // Verifique se o valor de curso está chegando corretamente no servidor

  if (!curso) {
    return res.status(400).json({ error: 'Curso é obrigatório!' }); // Verifica se o curso está vazio
  }

  const query = 'INSERT INTO alunos (nome, idade, quantidade_trabalhos, curso) VALUES (?, ?, ?, ?)';
  db.run(query, [nome, idade, quantidade_trabalhos, curso], function(err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(200).json({ message: 'Aluno adicionado com sucesso!', id: this.lastID });
  });
});

// Endpoint para obter todos os alunos
app.get('/alunos', (req, res) => {
  const query = 'SELECT * FROM alunos';
  db.all(query, (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(200).json(rows);
  });
});

// Endpoint para adicionar professor
app.post('/add-professor', (req, res) => {
  const { nome, quantidade_trabalhos, curso } = req.body;
  const query = 'INSERT INTO professores (nome, quantidade_trabalhos, curso) VALUES (?, ?, ?)';
  db.run(query, [nome, quantidade_trabalhos, curso], function(err) {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(200).json({ message: 'Professor adicionado com sucesso!', id: this.lastID });
  });
});

// Endpoint para obter todos os professores
app.get('/professores', (req, res) => {
  const query = 'SELECT * FROM professores';
  db.all(query, (err, rows) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(200).json(rows);
  });
});

app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});