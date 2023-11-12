const express = require('express');
const router = express.Router();

const app = require('../controllers/app')

router.route('/')
    .get(app.showLogin)

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

router.route('/ventasinternas')
    .get(app.showVentasInternas)

router.route('/ventasexternas')
    .get(app.showVentasExternas) 

router.route('/quejas')
    .get(app.showQuejas)


module.exports = router;