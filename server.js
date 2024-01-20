import express from "express";
import path from "path";

let app = express();

app.get("/", (req, res) => {
  res.sendFile("/index.html", { root: "." });
});

app.listen(3000, () => {
  console.log("app listening on port 3000!");
});
