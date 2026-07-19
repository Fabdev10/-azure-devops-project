const express = require('express');
const { Client } = require('pg');

const app = express();
const port = process.env.PORT || 3000;

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from backend' });
});

app.get('/api/db-check', async (req, res) => {
  const client = new Client({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT || 5432,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    ssl: process.env.DB_SSL === 'true' ? { rejectUnauthorized: false } : false
  });

  try {
    await client.connect();
    await client.query('SELECT 1');
    await client.end();
    res.json({ status: 'success', message: 'Successfully connected to database' });
  } catch (error) {
    res.status(500).json({ status: 'error', message: 'Database connection failed', error: error.message });
  }
});

app.listen(port, () => {
  console.log(`Backend listening on port ${port}`);
});
