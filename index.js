const express = require("express");
const cors = require('cors');
const colors = require('colors');
const dotenv = require('dotenv').config();
const { errorHandler } = require("./middleware/errorMiddleware");
const db = require('./config/db')


const app = express();



app.use(cors());
app.use(express.json())
app.use(express.urlencoded({extended: false}))

// app.use(express.static('public'));
app.use('/images', express.static('images'));
// app.use('/ressources', express.static('ressources'));

app.use('/api/user', require('./routes/userRoutes'));
app.use('/api/menu', require('./routes/menuRoutes'));
app.use('/api/table', require('./routes/tableRoutes'));
app.use('/api/order', require('./routes/orderRoutes'));
app.use('/api/book', require('./routes/bookRoutes'));
app.use(errorHandler)
app.listen(process.env.PORT, ()=> {
    console.log(`Server Started on port : ${process.env.PORT}`);
})

