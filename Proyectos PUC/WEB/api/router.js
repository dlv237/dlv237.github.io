const Router = require('koa-router');
const router = new Router();
const path = require('path');
const userController = require('./controllers/userController');
const lobbyController = require('./controllers/lobbyController');
const territoryController = require('./controllers/territoryController');
const userRegionController = require('./controllers/userregionController');



router.post('/territories', territoryController.createTerritories)
// Rutas!

router.get('/usuarios', userController.getUsers)
router.post('/usuarios', userController.createUser);
router.delete('/usuarios', async (ctx) => { console.log('borrar cuenta de un usuario')})

// Rutas de lobby!!

router.post('/lobbys', lobbyController.createLobby)
router.get('/lobbys', lobbyController.getLobbys)

router.get('/lobbys/:lobbyId', lobbyController.getLobby)
router.patch('/lobbys/:id', lobbyController.startGame)

router.post('/lobbys/:id/users', lobbyController.addUser)
router.delete('/lobbys/:id/users', lobbyController.removeUser)
router.get('/lobbys/:lobbyId/users', lobbyController.getUsers)

router.patch('/lobbys/:lobbyId/users/:userId', lobbyController.changeUserState)

// Rutas de JUEGO!!
router.post('/game/:lobbyId', territoryController.randomizeTerritories)
router.get('/game/:lobbyId', territoryController.getMap)
router.get('/game/:lobbyId/attack', userRegionController.attackTerritory)
router.post('/game/:lobbyId/moveUnits', userRegionController.moveUnits)

module.exports = router;