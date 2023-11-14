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
    res.render('home.ejs')
}

module.exports.showDashboard = async (req, res) => {
    const resultado1 = await pool.query('SELECT * FROM vista_distribuidora_estado ORDER BY(cantidad) DESC')
    const resultado2 = await pool.query('SELECT * FROM vista_pozo_estado ORDER BY(cantidad) DESC')
    const distribuidora_estado = resultado1.rows
    const pozo_estado = resultado2.rows
    res.render('dashboard', {distribuidora_estado, pozo_estado})
}

module.exports.showProduccionTime = async (req, res) => {
    const resultado = await pool.query('SELECT * FROM vista_produccion_anual')
    res.send(resultado)
    return resultado
}

module.exports.showPozoGrafica = async (req, res) => {
    const resultado = await pool.query('SELECT * FROM vista_pozo_estado ORDER BY(cantidad) DESC')
    res.send(resultado)
    return resultado
}

module.exports.showPozos = (req, res) => {
    pool.query('SELECT pozo.id_pozo, estado.nombre, pozo.periodo FROM pozo JOIN estado ON pozo.id_estado = estado.id_estado', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('pozos/index', { datos })
    })
}

module.exports.showNewPozo = async(req, res) => {
    const datos = await pool.query('SELECT MAX(id_pozo) FROM pozo')    
    const estados = await pool.query('SELECT * FROM estado')
    res.render('pozos/new', { datos, estados })
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

module.exports.showEditPozo = async(req, res) => {
    const id = req.params.id
    const datos = await pool.query('SELECT * FROM pozo WHERE id_pozo = $1', [id],)    
    const estados = await pool.query('SELECT * FROM estado')
    res.render('pozos/edit', { datos, estados })
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

module.exports.showDistribuidoras = async(req, res) => {
    const datos = await pool.query('SELECT distribuidora.id_distribuidora, estado.nombre, distribuidora.id_pozo, distribuidora.ubicacion, distribuidora.cp FROM distribuidora JOIN estado ON distribuidora.id_estado = estado.id_estado')
    const productos = await pool.query('SELECT magna, premium, diesel, dme FROM productos')
    res.render('distribuidoras/index', { datos, productos })
}

module.exports.showNewDistribuidora = async(req, res) => {
    const datos = await pool.query('SELECT MAX(id_distribuidora) FROM distribuidora')    
    const estados = await pool.query('SELECT * FROM estado')
    const pozos = await pool.query('SELECT * FROM pozo ORDER by (id_pozo)')
    res.render('distribuidoras/new', { datos, estados, pozos })
}

module.exports.registerDistribuidora = async (req, res) => {
    const { id_distribuidora, pozo, location, cp } = req.body
    const estados = await pool.query('SELECT * FROM estado')
    const id_max = await pool.query('SELECT MAX(id_productos) FROM productos')
    const estado = await seleccionarEstado(estados, cp)
    const productos = seleccionProductos(req.body)
    productos.unshift(id_distribuidora)
    if(id_max.rows[0].max == null){
        productos.unshift(1)
    }else{
        productos.unshift(id_max.rows[0].max+1)
    }
    pool.query('INSERT INTO distribuidora (id_distribuidora, id_estado, id_pozo, ubicacion, cp) VALUES ($1, $2, $3, $4, $5) ', [id_distribuidora, estado, pozo, location, cp], (error, results) => {
        if (error) {
            throw error
        }
    })
    pool.query('INSERT INTO productos (id_productos, id_distribuidora, magna, premium, diesel, dme) VALUES ($1, $2, $3, $4, $5, $6) ', productos, (error, results) => {
        if (error) {
            throw error
        }
        res.redirect('/distribuidoras')
    }) 
}

module.exports.showEditDistribuidora = async(req, res) => {
    const id = req.params.id
    const datos = await pool.query('SELECT * FROM distribuidora WHERE id_distribuidora = $1', [id])    
    const productos = await pool.query('SELECT * FROM productos WHERE id_distribuidora = $1', [id])
    const estados = await pool.query('SELECT * FROM estado')
    const pozos = await pool.query('SELECT * FROM pozo ORDER by (id_pozo)')
    res.render('distribuidoras/edit', { datos, estados, pozos, productos })
}

module.exports.updateDistribuidora = async(req, res) => {
    const id = req.params.id
    const { pozo, location, cp } = req.body
    const estados = await pool.query('SELECT * FROM estado')
    const estado = await seleccionarEstado(estados, cp)
    const productos = seleccionProductos(req.body)
    productos.push(id)
    pool.query('UPDATE distribuidora SET id_estado=$1, id_pozo=$2, ubicacion=$3, cp=$4 WHERE id_distribuidora = $5;',
        [estado, pozo, location, cp, id],
        (error, results) => {
            if (error) {
                throw error
            }
        }
    )
    pool.query('UPDATE productos SET magna=$1, premium=$2, diesel=$3, dme=$4 WHERE id_distribuidora=$5;', productos, (error, results) => {
        if (error) {
            throw error
        }
        res.redirect('/distribuidoras')
    }) 
}

module.exports.deleteDistribuidora = (req, res) => {
    const id = req.params.id

    pool.query('DELETE FROM distribuidora WHERE id_distribuidora = $1', [id], (err, results) => {
        if (err) {
            new ExpressError('Pagina No Encontrada', 404)
            return res.render('error', { err })
        }
        res.redirect('/distribuidoras')
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
    pool.query('SELECT * FROM quejas', (error, results) => {
        if (error) {
            throw error
        }
        const datos = results.rows
        res.render('quejas/index', { datos })
    })
}

module.exports.showNewQuejas = async (req, res) => {
    const datos = await pool.query('SELECT MAX(id_queja) FROM quejas')    
    const distribuidoras = await pool.query('SELECT id_distribuidora FROM distribuidora')
    res.render('quejas/new', { datos, distribuidoras })
}

module.exports.registerQueja = async (req, res) => {
    const { queja, distribuidora, estado, anio } = req.body
    
    pool.query('INSERT INTO quejas (id_queja, id_distribuidora, estado, anio) VALUES ($1, $2, $3, $4) ', [queja, distribuidora, estado, anio], (error, results) => {
        if (error) {
            throw error
        }
        res.redirect('/quejas')
    })
}

module.exports.showEditQuejas = async (req, res) => {
    const id = req.params.id
    const datos = await pool.query('SELECT * FROM quejas WHERE id_queja = $1', [id])    
    const distribuidoras = await pool.query('SELECT id_distribuidora FROM distribuidora')
    res.render('quejas/edit', { datos, distribuidoras })
}

module.exports.updateQueja = async(req, res) => {
    const id = req.params.id
    const { distribuidora, estado, anio} = req.body    
    console.log(req.body)
    pool.query(
        'UPDATE quejas SET id_distribuidora=$1, estado=$2, anio=$3 WHERE id_queja = $4;',
        [distribuidora, estado, anio, id],
        (error, results) => {
            if (error) {
                throw error
            }
            console.log(results)
            res.redirect('/quejas')
        }
    )
}

module.exports.deleteQueja = (req, res) => {
    const id = req.params.id
    pool.query('DELETE FROM quejas WHERE id_queja = $1', [id], (err, results) => {
        if (err) {
            new ExpressError('Pagina No Encontrada', 404)
            return res.render('error', { err })
        }
        res.redirect('/quejas')
    })
}

function seleccionarEstado(estados, cp){
    for(i=0; i<estados.rows.length; i++){
        if(estados.rows[i].min_cp <= cp && estados.rows[i].max_cp >= cp){
            return estados.rows[i].id_estado
        }
    }
}

function seleccionProductos(datos){
    let resultados = []
    let arreglo = ['magna', 'premium', 'diesel', 'dme']
    for(producto in arreglo){
        resultados.push(datos.hasOwnProperty(arreglo[producto]))
    }
    return resultados
}
