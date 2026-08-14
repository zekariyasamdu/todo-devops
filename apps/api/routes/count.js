var express = require("express");
const { CHANGE_COUNT } = require("../db/query");
var router = express.Router();

router.put("/:num", async function (req, res, next) {
  try {
    const { num } = req.params;
    await CHANGE_COUNT(Number(num));
    res.json({ success: true });
  } catch (e) {
    console.log(e);
    res.json({ success: false });
  }
});

module.exports = router;
