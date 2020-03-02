const http = require('http');
const { Client } = require('pg')

const port = process.env.PORT || 3000;
const client = new Client({ 
  connectionString: process.env.DATABASE_URL,
  ssl: true,
});

const execute = async () => {
  try {
    // CONNECT TO DATABASE
    await client.connect()
    const res = await client.query('SELECT $1::text as message', ['Hello world!'])
    const hello = res.rows[0].message;
    await client.end();

    // SERVER
    const server = http.createServer((req, res) => {
      res.statusCode = 200;
      res.setHeader('Content-Type', 'text/plain');
      res.end(hello);
    });
    server.listen(port, () => {
      console.log(`Server running on port ${port}`);
    });
  } catch (err) {
      console.log('Failed to start server');
      console.log(err);
  }
};

execute();
