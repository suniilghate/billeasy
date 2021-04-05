const Pool = require('pg').Pool;

const pool = new Pool ({
    user : process.env.USER || 'postgres',
    host : process.env.HOST || 'localhost',
    database : process.env.DATABASE || 'employees',
    password : process.env.PASSWORD || '123456',
    port : process.env.POOLPORT || '5432'
});

module.exports = pool;