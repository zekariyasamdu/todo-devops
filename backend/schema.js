const { pgTable, serial, integer } = require("drizzle-orm/pg-core");

const count = pgTable("count", {
  id: serial("id").primaryKey(),
  count: integer("count"),
});

module.exports = { count };
