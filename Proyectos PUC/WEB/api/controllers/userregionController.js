const UserRegion = require('../models/userregion');
const TerritoryNeighbor = require('../models/territoryneighbor');

async function asignarTerritorioConUnidad(lobbyId, userId, territoryId, unidadCount) {
    try {
        await UserRegion.create({
            lobbyId,
            userId,
            territoryId,
            unity_count: unidadCount
        });
        return { success: true, message: 'Territorio asignado con éxito' };
    } catch (error) {
        console.error('Error al asignar territorio con unidad:', error);
        return { success: false, error: 'Error al asignar territorio con unidad' };
    }
}

async function attackTerritory(ctx) {
    try {
        const { lobbyId, attackerId, attackerTerritoryId, defensorId, defensorTerritoryId, unit_count, diceCount} = ctx.request.body;

        // Tirar el dado se gestiona aqui
        const attackerRegion = await UserRegion.findOne({ where: { lobbyId, attackerId, attackerTerritoryId } });
        const defensorRegion = await UserRegion.findOne({ where: { lobbyId, defensorId, defensorTerritoryId } });


        // roadmap, para entender mejor

        // reviso si el territorio del atacante y el defensor existen
        if (!attackerRegion || !defensorRegion) {
            ctx.status = 404;
            ctx.body = { error: 'Territorio no encontrado' };
            return;
        }

        // reviso si los territorios son vecinos
        const neighbors = await TerritoryNeighbor.findAll({ where: { territoryId: attackerTerritoryId, neighborId: defensorTerritoryId } });

        if (!neighbors) {
            ctx.status = 400;
            ctx.body = { error: 'Territorios no son vecinos' };
            return;
        }

        // reviso si el atacante tiene suficientes unidades o si estan dentro del rango permitido
        if (!(1 < unit_count < 5) || (unit_count > attackerRegion.unity_count) || (unit_count < diceCount) || (diceCount > 3)){
            ctx.status = 400;
            ctx.body = { error: 'Cantidad de unidades o dados inválida' };
            return;
        }

        let attackerDiceList = [];
        let defensorDiceList = [];

        for (intento = 0; intento < diceCount; intento++) {
            const attackerDice = Math.floor(Math.random() * 6) + 1;
            if (attackerDice > Math.max(...attackerDiceList)) {
                attackerDiceList.unshift(attackerDice);
            } else {
                attackerDiceList.push(attackerDice);
            }
        }

        for (intento = 0; intento < Math.min(2, diceCount); intento++) {
            if (intento < defensorRegion.unity_count) {
                const defensorDice = Math.floor(Math.random() * 6) + 1;
            }
            else {
                const defensorDice = 0;
            }
            if (defensorDice > Math.max(...defensorDiceList)) {
                defensorDiceList.unshift(defensorDice);
            } else {
                defensorDiceList.push(defensorDice);
            }

        }

        for (intento; intento < defensorDiceList.length; intento++) {
            if (attackerDiceList){
                if (attackerDiceList[intento] > defensorDiceList[intento]) {
                    defensorRegion.unity_count -= 1;
                    if (defensorRegion.unity_count == 0) {
                        defensorRegion.userId = attackerId;
                        defensorRegion.unity_count = 1;
                        attackerRegion.unity_count -= unit_count;
                        break;
                    }
                } else {
                    attackerRegion.unity_count -= 1;
                }
            }
        }

        //ahora enfrento los territorios



        // Desde el front gestionamos como cambia la información

        // El usuario al atacar anuncia la cantidad de dados a tirar
        // El defensor si o si se defiende a estos dados?
        // ambas tiradas son gestionadas acá y se retorna una lista con los resultados
        // el front verá como mostrar los lanzamientos de dados, 
        // habrá que hacerle 'creer´al usuario que interactua con los dados paso por paso
        // pero el resultado sigue siendo el mismo a si que no afecta al juego justo

        // el resultado del ataque no es retornado en esta funcion
        // el front se encarga de recibir el estado del mapa, entonces es mucho mas óptimo

        ctx.status = 200;
        ctx.body = { message: 'Territorio atacado con éxito',
            result: diceList
         };
    
    }
    catch{
        console.error('Error al atacar territorio:', error);
        ctx.status = 500;
    }
}

async function moveUnits(ctx) {
    try {
        const { lobbyId, userId, originTerritoryId, destinationTerritoryId, unit_count } = ctx.request.body;
        
        const neighbors = await TerritoryNeighbor.findAll({ where: { territoryId: originTerritoryId, neighborId: destinationTerritoryId } });

        if (!neighbors) {
            ctx.status = 400;
            ctx.body = { error: 'No son vecinos' };
            return;
        }

        const originRegion = await UserRegion.findOne({ where: { lobbyId, userId, originTerritoryId } });
        const destinationRegion = await UserRegion.findOne({ where: { lobbyId, userId, destinationTerritoryId } });

        if (!originRegion || !destinationRegion) {
            ctx.status = 404;
            ctx.body = { error: 'El usuario no corresponde a estos territorios' };
            return;
        }

        if (unit_count > originRegion.unity_count + 1) {
            ctx.status = 400;
            ctx.body = { error: 'No puedes mover esta cantidad de tropas' };
            return;
        }

        originRegion.unity_count -= unit_count;
        destinationRegion.unity_count += unit_count;

        ctx.status = 200;
        ctx.body = { message: 'Unidades movidas con éxito' };
    }
    catch{
        console.error('Error al mover unidades:', error);
        ctx.status = 500;
    }
}

module.exports = { 
    asignarTerritorioConUnidad,
    attackTerritory,
    moveUnits
 };
