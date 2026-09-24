const { db } = require("./db/index");
const { sql } = require("drizzle-orm");

async function insertData() {
  await db.execute(sql`INSERT INTO count (count) VALUES (0);`);
  console.log("success");
}

insertData();
