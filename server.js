const express = require('express');
const dotenv = require('dotenv');
const path = require('path');
const employeeRoutes = require('./src/employee/routes');
const bodyParser = require('body-parser');

const app = express();

dotenv.config({path : '.env'});
const PORT = process.env.PORT || 3000;

//app.use(express.json());
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
 
// parse application/json
app.use(bodyParser.json())

//Routes
app.get('/', (req, res) => {
    res.send('Welcome to Nodejs Express Postgress Rest App');
});

//Employee Routes
app.use('/api/v1/employees', employeeRoutes);

app.listen(PORT, () => console.log(`app is listing port ${PORT}`));