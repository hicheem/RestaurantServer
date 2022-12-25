const mysql = require("mysql2");

const db = mysql.createConnection({
    user: "root",
    host: "192.168.1.8",
    password: "hichem",
    port: "3307",
    database: "restaurant"
});

module.exports = db;