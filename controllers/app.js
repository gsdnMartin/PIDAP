const pg = require('pg');
pg.types.setTypeParser(1114, function (stringValue) {
    return stringValue;  //1114 for time without timezone type
});

pg.types.setTypeParser(1082, function (stringValue) {
    return stringValue;  //1082 for date type
});
const pool = require('../utils/postgresql')
const ExpressError = require('../utils/ExpressError');

module.exports.showLogin = (req, res) => {
    res.render('login')
}

module.exports.showDashboard = (req, res) => {
    res.render('dashboard')
}

module.exports.showPozos = (req, res) => {
    pool.query('SELECT * FROM pozo', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('pozos/index', { datos })
    })
}

module.exports.showNewPozo = (req, res) => {
    pool.query('SELECT MAX(id_pozo) FROM pozo', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows[0]
        res.render('pozos/new', { datos })
    })
}

module.exports.registerPozo = (req, res) => {
    const { id_pozo, estado, periodo } = req.body

    pool.query('INSERT INTO pozo (id_pozo, id_estado, periodo) VALUES ($1, $2, $3) ', [id_pozo, estado, periodo], (error, results) => {
        if (error) {
            throw error
        }
        res.redirect('/pozos')
    })
}

module.exports.showEditPozo = (req, res) => {
    const id = req.params.id
    pool.query('SELECT * FROM pozo WHERE id_pozo = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('pozos/edit', { datos })
    })
}

module.exports.updatePozo = (req, res) => {
    const id = req.params.id
    const { estado, periodo } = req.body

    pool.query(
        'UPDATE pozo SET id_estado = $1, periodo = $2 WHERE id_pozo = $3',
        [estado, periodo, id],
        (error, results) => {
            if (error) {
                throw error
            }
            res.redirect('/pozos')
        }
    )
}

module.exports.deletePozo = (req, res) => {
    const id = req.params.id

    pool.query('DELETE FROM pozo WHERE id_pozo = $1', [id], (err, results) => {
        if (err) {
            new ExpressError('Pagina No Encontrada', 404)
            return res.render('error', { err })
        }
        res.redirect('/pozos')
    })
}

module.exports.showDistribuidoras = (req, res) => {
    pool.query('SELECT * FROM distribuidora', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('distribuidoras', { datos })
    })
}

module.exports.showVentasInternas = (req, res) => {
    pool.query('SELECT * FROM ventas_internas', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('ventasinternas', { datos })
    })
}

module.exports.showVentasExternas = (req, res) => {
    pool.query('SELECT * FROM ventas_internas', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('ventasexternas', { datos })
    })
}

module.exports.showQuejas = (req, res) => {
    pool.query('SELECT * FROM ventas_internas', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('quejas', { datos })
    })
}
