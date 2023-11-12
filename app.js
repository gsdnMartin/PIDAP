const express = require('express')
const app = express()
const ejsMate = require('ejs-mate');
const bodyParser = require('body-parser') 
const methodOverride = require('method-override');
const ExpressError = require('./utils/ExpressError');
const path = require('path')

const appRoute = require('./routes/app')

app.engine('ejs', ejsMate)
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))

app.use(express.static(path.join(__dirname, 'public')))
app.use(express.urlencoded({ extended: true }));
app.use(methodOverride('_method'));
app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.use('/', appRoute)

app.all('*', (req, res, next) => {
    next(new ExpressError('Pagina No Encontrada', 404))
})

app.use((err, req, res, next) => {
    const { statusCode = 500 } = err;
    if (!err.message) err.message = 'Oh No, Algo Salio Mal!'
    res.status(statusCode).render('error', { err })
})

app.listen(3000, () => {
    console.log('PIDAP Funcionando')
})