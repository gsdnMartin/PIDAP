const Pool = require('pg').Pool
const pool = new Pool({
  user: 'mots',
  host: 'localhost',
  database: 'pidap',
  password: 'linux-admin1',
  port: 5432,
})

module.exports = pool