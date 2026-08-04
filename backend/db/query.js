const { db } = require("./index");
const { sql } = require("drizzle-orm");

async function SELECT_COUNT() {
  const result = await db.execute(sql`
    SELECT count
    FROM count
    LIMIT 1
  `);

  return result.rows[0];
}

async function CHANGE_COUNT(num) {
  await db.execute(sql`
    UPDATE count
    SET count = ${num}
    WHERE id = (SELECT MIN(id) FROM count)
  `);
}

module.exports = {
  SELECT_COUNT,
  CHANGE_COUNT,
};
