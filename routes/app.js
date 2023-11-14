const express = require('express');
const router = express.Router();

const app = require('../controllers/app')

router.route('/')
    .get(app.showLogin)

router.route('/recursos/produccionGrafica')
    .get(app.showProduccionTime)

router.route('/recursos/pozoGrafica')
    .get(app.showPozoGrafica)

router.route('/dashboard')
    .get(app.showDashboard)

router.route('/pozos')
    .get(app.showPozos)
    .post(app.registerPozo)

router.route('/pozos/nuevo')
    .get(app.showNewPozo)    

router.route('/pozos/:id')
    .get(app.showEditPozo)
    .put(app.updatePozo)
    .delete(app.deletePozo)

router.route('/distribuidoras')
    .get(app.showDistribuidoras)
    .post(app.registerDistribuidora)

router.route('/distribuidoras/nuevo')
    .get(app.showNewDistribuidora)

router.route('/distribuidoras/:id')
    .get(app.showEditDistribuidora)
    .put(app.updateDistribuidora)
    .delete(app.deleteDistribuidora)

router.route('/ventasinternas')
    .get(app.showVentasInternas)
    .post(app.registerVI)

router.route('/ventasinternas/nuevo')
    .get(app.showNewVentasInternas) 

router.route('/ventasinternas/:id')
    .get(app.showEditVI) 
    .put(app.updateVI)
    .delete(app.deleteVI)

router.route('/comercioexterior')
    .get(app.showComercioExterior) 
    .post(app.registerCE)

router.route('/comercioexterior/nuevo')
    .get(app.showNewComercioExterior) 

router.route('/comercioexterior/:id')
    .get(app.showEditCE) 
    .put(app.updateCE)
    .delete(app.deleteCE)

router.route('/quejas')
    .get(app.showQuejas)
    .post(app.registerQueja)

router.route('/quejas/nuevo')
    .get(app.showNewQuejas)

router.route('/quejas/:id')
    .get(app.showEditQuejas)
    .put(app.updateQueja)
    .delete(app.deleteQueja)


module.exports = router;