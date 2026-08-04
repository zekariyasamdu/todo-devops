const { drizzle } = require("drizzle-orm/node-postgres");
const pg = require("pg");

const pool = new pg.Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

const db = drizzle(pool);
module.exports = { db };
