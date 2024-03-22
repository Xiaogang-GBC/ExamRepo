const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => res.send('This is a sample project created for exam!'));

app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`));
