const sequelize = require('./api/models/sequelize.js');
const Koa = require('koa');
const bodyParser = require('koa-bodyparser'); 
const apiRouter = require('./api/router.js');
const territoriesRouter = require('./api/controllers/territoryController.js');
const checkTableExists = require('./api/tablasCheck.js');


const app = new Koa();

app.use(bodyParser());
app.use(apiRouter.routes());
app.use(apiRouter.allowedMethods());

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor KoaJS escuchando en el puerto ${PORT}`);
});
