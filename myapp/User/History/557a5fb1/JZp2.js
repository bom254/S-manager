const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

// Create a connection to the database
const db = mysql.createConnection({
    host: 'localhost',
    user: 'your_username', // replace with your MySQL username
    password: 'your_password', // replace with your MySQL password
    database: 'student_management'
});

// Connect to the database
db.connect(err => {
    if (err) {
        console.error('Database connection failed: ' + err.stack);
        return;
    }
    console.log('Connected to database.');
});

// Get all students
app.get('/api/students', (req, res) => {
    db.query('SELECT * FROM students', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Add a new student
app.post('/api/students', (req, res) => {
    const { name, email, age, course } = req.body;
    db.query('INSERT INTO students (name, email, age, course) VALUES (?, ?, ?, ?)', [name, email, age, course], (err, results) => {
        if (err) return res.status(500).send(err);
        res.status(201).json({ id: results.insertId, name, email, age, course });
    });
});

// Update a student
app.put('/api/students/:id', (req, res) => {
    const { id } = req.params;
    const { name, email, age, course } = req.body;
    db.query('UPDATE students SET name = ?, email = ?, age = ?, course = ? WHERE id = ?', [name, email, age, course, id], (err) => {
        if (err) return res.status(500).send(err);
        res.send('Student updated successfully');
    });
});

// Delete a student
app.delete('/api/students/:id', (req, res) => {
    const { id } = req.params;
    db.query('DELETE FROM students WHERE id = ?', [id], (err) => {
        if (err) return res.status(500).send(err);
        res.send('Student deleted successfully');
    });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});