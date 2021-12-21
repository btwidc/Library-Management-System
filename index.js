'use strict';

const express = require('express');
const config = require('./config');
const cors = require('cors');
const bodyParser = require('body-parser');
const path = require('path');
const eventRoutes = require('./routes/eventRoutes');

const app = express();

app.set('json spaces', 1);
app.use(cors());

app.use(bodyParser.json());

app.use('/api', eventRoutes.routes);

app.get('/', (req, res) => {
  res.render('index');
});

app.listen(config.port, () => console.log('Server is listening on http://localhost:' + config.port));