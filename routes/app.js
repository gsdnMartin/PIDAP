const express = require('express');
const router = express.Router();

const app = require('../controllers/app')

router.route('/')
    .get(app.showLogin)

router.route('/dashboard')
    .get(app.showDashboard)

router.route('/pozos')
    .get(app.showPozos)

router.route('/distribuidoras')
    .get(app.showDistribuidoras)

router.route('/ventasinternas')
    .get(app.showVentasInternas)

router.route('/ventasexternas')
    .get(app.showVentasExternas) 

router.route('/quejas')
    .get(app.showQuejas)


module.exports = router;