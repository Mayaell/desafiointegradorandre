const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());
app.use(express.json());  // Para ler os dados em formato JSON

// Conectar ao MySQL
const db = mysql.createConnection({
  host: 'localhost',  // ou o endereço do seu servidor de banco de dados
  user: 'root',       // Seu usuário do MySQL
  password: '1234',   // Sua senha do MySQL
  database: 'memorial_faculdade'  // Seu banco de dados
});

db.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados: ' + err.stack);
    return;
  }
  console.log('Conectado ao banco de dados como id ' + db.threadId);
});

// Endpoint para adicionar aluno
app.post('/add-aluno', (req, res) => {
    const { nome, idade, quantidade_trabalhos, curso } = req.body;
  
    console.log('Recebido curso:', curso); // Verifique se o valor de curso está chegando corretamente no servidor
  
    if (!curso) {
      return res.status(400).json({ error: 'Curso é obrigatório!' }); // Verifica se o curso está vazio
    }
  
    const query = 'INSERT INTO alunos (nome, idade, quantidade_trabalhos, curso) VALUES (?, ?, ?, ?)';
    db.query(query, [nome, idade, quantidade_trabalhos, curso], (err, results) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }
      res.status(200).json({ message: 'Aluno adicionado com sucesso!', id: results.insertId });
    });
  });
  

// Endpoint para obter todos os alunos
app.get('/alunos', (req, res) => {
  const query = 'SELECT * FROM alunos';
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(200).json(results);
  });
});

// Endpoint para adicionar professor
app.post('/add-professor', (req, res) => {
  const { nome, quantidade_trabalhos, curso } = req.body;
  const query = 'INSERT INTO professores (nome, quantidade_trabalhos, curso) VALUES (?, ?, ?)';
  db.query(query, [nome, quantidade_trabalhos, curso], (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(200).json({ message: 'Professor adicionado com sucesso!', id: results.insertId });
  });
});

// Endpoint para obter todos os professores
app.get('/professores', (req, res) => {
  const query = 'SELECT * FROM professores';
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({ error: err.message });
    }
    res.status(200).json(results);
  });
});

// Iniciar o servidor
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
