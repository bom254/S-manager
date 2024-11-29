const express = require('express');
const pool = require('./config/db')
const app = express()
const port = 3000

// Middleware to handle JSON requests
app.use(express.json())

// Routes
// app.get('/api/data', (req, res) => {
//     pool.query('SELECT * FROM ')
// })

// Start the server 
app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

// Handle server shutdown
process.on('SIGINT', () => {
    pool.end(() => {
        console.log('Database connection pool has ended');
        process.exit(0);
    });
});