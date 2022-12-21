const mysql = require("mysql2");

const db = mysql.createConnection({
    user: "root",
    host: "localhost",
    password: "hichem",
    port: "3307",
    database: "restaurant"
});

module.exports = db;