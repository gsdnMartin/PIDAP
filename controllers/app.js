module.exports.showLogin = (req, res) => {
    res.render('login')
}

module.exports.showDashboard = (req, res) => {
    res.render('dashboard')
}

module.exports.showPozos = (req, res) => {
    res.render('pozos')
}

module.exports.showDistribuidoras = (req, res) => {
    res.render('distribuidoras')
}

module.exports.showVentasInternas = (req, res) => {
    res.render('ventasinternas')
}

module.exports.showVentasExternas = (req, res) => {
    res.render('ventasexternas')
}

module.exports.showQuejas = (req, res) => {
    res.render('quejas')
}