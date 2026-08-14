var express = require("express");
const { SELECT_COUNT } = require("../db/query");
var router = express.Router();

router.get("/", async function (req, res, next) {
  try {
    const data = await SELECT_COUNT();
    res.json({ count: data.count });
  } catch (e) {
    console.log(e);
  }
});
module.exports = router;
