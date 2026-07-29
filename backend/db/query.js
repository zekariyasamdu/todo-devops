const db = require("./index.js");

async function SELECT_COUNT() {
  const data = db.one("SELECT count from count;");
  return data;
}

async function CHANGE_COUNT(num) {
  const data = db.one(
    `UPDATE count SET count = ${num} WHERE id = (SELECT MIN(id) FROM count);`,
  );
  return data;
}
module.exports = { SELECT_COUNT, CHANGE_COUNT };
