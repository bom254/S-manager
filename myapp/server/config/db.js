const express = require('express');
const app = express();
const mysql = require('mysql2');
require('dotenv').config();

// Connecting to the database
const client = mysql.createConnection({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    password: process.env.DB_PASS
});

client.connect((err) => {
    if(err) {
        return console.log('Error connecting to mysql', err);
    }

    console.log('Connected successfully', client.threadId);
});

app.listen(process.env.port, () => {
    console.log(`Server is running on http://localhost:${process.env.port}`);
});

module.exports = client;