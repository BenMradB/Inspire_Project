require('dotenv').config();
const express = require('express');
const cookieParser = require('cookie-parser');
const db = require('./config/db');
const authRouter = require('./routes/auth');

const PORT = process.env.PORT || 3000;

const app = express();

// Middleware && static files
app.use(express.static('public'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(cookieParser());

// Set View Engine
app.set('view engine', 'ejs');

// Connect With The DB
db.connect(err => {
    if (err) throw err;
    app.listen(PORT, () => console.log(`Server Listening For Requests On Port ${PORT}`) );
});

// Set Routes
app.use('/', authRouter);

// 404 Page
app.use((req, res) => {
    return res.render('404')
});