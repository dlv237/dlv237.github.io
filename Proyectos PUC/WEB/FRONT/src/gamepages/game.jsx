import React, { useEffect, useState, useContext } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';
import './game.css';
import UserContext from '../userpages/usercontext';

const hexagonPoints = "0,-45 39,-22.5 39,22.5 0,45 -39,22.5 -39,-22.5";

const getTerritoryPosition = (territoryId) => {
  const positions = {
    1: { x: 110, y: 150 },
    2: { x: 195, y: 150 },
    3: { x: 68, y: 225 },
    4: { x: 153, y: 225 },
    5: { x: 110, y: 300 },
    6: { x: 195, y: 300 },
    7: { x: 153, y: 375 },
    8: { x: 280, y: 300 },
    9: { x: 350, y: 100 },
    10: { x: 435, y: 100 },
    11: { x: 400, y: 230 },
    12: { x: 485, y: 230 },
    13: { x: 442, y: 305 },
    14: { x: 527, y: 305 },
    15: { x: 485, y: 380 },
    16: { x: 320, y: 450 },
    17: { x: 600, y: 100 },
    18: { x: 685, y: 100 },
    19: { x: 770, y: 100 },
    20: { x: 855, y: 100 },
    21: { x: 642, y: 175 },
    22: { x: 727, y: 175 },
    23: { x: 813, y: 175 },
    24: { x: 685, y: 250 },
    25: { x: 642, y: 325 },
    26: { x: 900, y: 250 },
    27: { x: 856, y: 325 },
    28: { x: 943, y: 325 },
    29: { x: 900, y: 400 },
    30: { x: 1050, y: 175 },
    31: { x: 1135, y: 175 },
    32: { x: 1093, y: 250 },
  };
  return positions[territoryId] || { x: 0, y: 0 };
};

const HexMap = () => {
  const { id } = useParams();
  const [mapData, setMapData] = useState([]);
  const [inventoryInfo, setInventoryInfo] = useState([]);
  const [actualTurn, setActualTurn] = useState([]);
  const [highlightedTerritory, setHighlightedTerritory] = useState(null);
  const [reinforceUnits, setReinforceUnits] = useState(0);
  const [moveUnits, setMoveUnits] = useState(0);
  const [selectedTerritory, setSelectedTerritory] = useState(null);
  const [attackingTerritory, setAttackingTerritory] = useState(null);
  const [unitsToAttack, setUnitsToAttack] = useState(0);
  const [targetTerritory, setTargetTerritory] = useState(null);
  const [movingTerritory, setMovingTerritory] = useState(null);
  const [isUserInTurn, setIsUserInTurn] = useState(false);
  const [destinationTerritory, setDestinationTerritory] = useState(null);
  const [diceResults, setDiceResults] = useState([]);
  const [attackConfirmed, setAttackConfirmed] = useState(false);
  const [battleResults, setBattleResults] = useState(null);
  const { user, token } = useContext(UserContext);
  const [usersPlays, setUsersPlays] = useState([]);

  const fetchData = async () => {
    try {
      const response = await axios.post(`http://3.19.16.195:3000/game/${id}` ,{} ,{ headers: { Authorization: `Bearer ${token}` } });
      const turnresponse = await axios.get(`http://3.19.16.195:3000/game/${id}/turn`, { headers: { Authorization: `Bearer ${token}` } });
      setMapData(response.data.map);
      setInventoryInfo(response.data.inventoryInfo);
      const userInTurn = turnresponse.data.userId === user.id;
      setIsUserInTurn(userInTurn);
      setActualTurn(turnresponse.data);
    } catch (error) {
      console.error('Error fetching data:', error);
    }
  };

  useEffect(() => {
    fetchData();
  }, [id]);

  const handleReinforceChange = (event) => {
    setReinforceUnits(parseInt(event.target.value));
  };

  const handleMoveChange = (event) => {
    setMoveUnits(parseInt(event.target.value));
  };

  const getPlayerColor = (userId) => {
    const colorMap = {
      0: '#f4a261', 
      1: '#e76f51', 
      2: '#2a9d8f', 
      3: '#264653', 
    };
  
    const colorIndex = userId % 4;
    return colorMap[colorIndex] || 'black'; 
  };

  const handlePassTurnButton = async () => {
    try {
      await axios.patch(`http://3.19.16.195:3000/game/${id}/passTurn`, { headers
        : { Authorization: `Bearer ${token}` } });
      await fetchData();
    }
    catch (error) {
      console.error('Error passing turn:', error);
      alert(error);
    }
  }

  const handleTerritoryClick = (territoryId, userId, troops) => {
    if (attackingTerritory) {
      if (territoryId !== attackingTerritory.territoryId) {
        setTargetTerritory({ territoryId, userId, troops });
      }
    } else if (movingTerritory) {
      if (territoryId !== movingTerritory.territoryId) {
        setDestinationTerritory({ territoryId, userId, troops });
      }
    } else {
      setSelectedTerritory({ territoryId, userId, troops });
    }
  };

  const handleReinforce = async () => {
    if (selectedTerritory && selectedTerritory.userId === user.id) {
      try {
        await axios.patch(`http://3.19.16.195:3000/game/${id}/reforze`, {
          userId: user.id,
          territoryId: selectedTerritory.territoryId,
          unit_count: reinforceUnits,
        },
        { headers: { Authorization: `Bearer ${token}` } });
        setReinforceUnits(0);
        let message = `Jugador ${user.id} reforzó ${reinforceUnits} unidades en el territorio ${selectedTerritory.territoryId}`;
        sendLog(message);
        await fetchData();
      } catch (error) {
        console.error('Error reinforcing territory:', error);
        alert(error);
      }
    } else {
      alert('Selecciona un territorio válido.');
    }
  };

  const handleAttack = () => {
    if (attackingTerritory && targetTerritory && unitsToAttack > 0) {
      setAttackConfirmed(true);
    } else {
      alert('Selecciona un territorio atacante, un objetivo y la cantidad de unidades para atacar.');
    }
  };
  
  const cancelAttack = () => {
    setAttackingTerritory(null);
    setTargetTerritory(null);
    setUnitsToAttack(0); 
  };

  const handleUnitSelection = (units) => {
    if (attackingTerritory.troops >= units) {
      setUnitsToAttack(units);
    } else {
      alert(`No tienes suficientes unidades en el territorio atacante. Tienes ${attackingTerritory.troops} unidades.`);
    }
  };

  const rollDice = () => {
    const results = [];
    for (let i = 0; i < Math.min(unitsToAttack - 1, 3); i++) {
      results.push(Math.floor(Math.random() * 6) + 1);
    }
    setDiceResults(results);
    
    sendAttack(results);
  };

  const sendLog = async (mensaje) => {
    try {
      const response = await axios.post(`http://3.19.16.195:3000/game/${id}/logs`, {
        log: mensaje,
        lobbyId: id,
      }, { headers: { Authorization: `Bearer ${token}` } });
      setUsersPlays([response.data]);
      console.log(response.data);
    } catch (error) {
      console.error('Error sending log:', error.error);

      alert(error);
    }
  }

  const sendAttack = async (diceResults) => {

    const mensaje = `Jugador ${user.id} lanzó dados dado y obtuvo: ${diceResults}`;
    sendLog(mensaje);
    
    try {
      const response = await axios.post(`http://3.19.16.195:3000/game/${id}/attack`, {
        attackerId: user.id,
        attackerTerritoryId: attackingTerritory.territoryId,
        defensorTerritoryId: targetTerritory.territoryId,
        defensorId: targetTerritory.userId,
        diceResults: diceResults
      }, { headers: { Authorization: `Bearer ${token}` } });
      
      const { battlesWon, battlesLost } = response.data;
  
      setBattleResults({ battlesWon, battlesLost });
      setAttackingTerritory(null);
      setTargetTerritory(null);
      setUnitsToAttack(0);
      setAttackConfirmed(false);
  
      await fetchData();
    } catch (error) {
      console.error('Error sending attack results:', error.error);
      alert(error);
    }

  }

  const handleMove = async () => {
    if (movingTerritory && destinationTerritory) {
      try {
        await axios.post(`http://3.19.16.195:3000/game/${id}/moveUnits`, {
          userId: user.id,
          originTerritoryId: movingTerritory.territoryId,
          destinationTerritoryId: destinationTerritory.territoryId,
          unit_count: moveUnits,
    },
        { headers: { Authorization: `Bearer ${token}` } });
        let message = `Jugador ${user.id} movió ${moveUnits} unidades del territorio ${movingTerritory.territoryId} al territorio ${destinationTerritory.territoryId}`;
        sendLog(message);
        await fetchData();
      } catch (error) {
        console.error('Error moving units:', error);
        alert(error);
      }
      
    } else {
      alert('Selecciona un territorio de origen y un destino.');
    }
  };

  const cancelMove = () => {
    setMovingTerritory(null);
    setDestinationTerritory(null);
    setMoveUnits(0);
};

  return (
    <div className="main-container">
      <div className="superior-container">
        <div className="turn">
          <h1>Turno actual: {actualTurn.id % 4}</h1>
        </div>
        <div className="hexmap-container">
          <svg width="1100" height="450" className="hexmap">
            <defs>
              <polygon id="hexagon" points={hexagonPoints} />
            </defs>
    
            {mapData.map((territory) => {
              const { x, y } = getTerritoryPosition(territory.territoryId);
    
              return (
                <g key={territory.territoryId}>
                  <use
                    href="#hexagon"
                    x={x}
                    y={y}
                    className={`hexagon user-${territory.userId}`}
                    onMouseOver={() => setHighlightedTerritory(territory.territoryId)}
                    onMouseOut={() => setHighlightedTerritory(null)}
                    onClick={() => handleTerritoryClick(territory.territoryId, territory.userId, territory.unityCount)}
                    style={{ fill: getPlayerColor(territory.userId), filter: highlightedTerritory === territory.territoryId ? 'brightness(150%)' : 'none' }}
                  />
                  <text x={x} y={y} className="label">{territory.territoryId}, tropas: {territory.unityCount}</text>
                </g>
              );
            })}
          </svg>
        </div>
        <div className="inventory-container">
          <h2>Inventario de Jugadores</h2>
          <ul>
            {inventoryInfo.map((player) => (
              <li key={player.userId}>
                <span style={{ color: getPlayerColor(player.userId) }}>Jugador {player.userId % 4}</span>: {player.unityCount} unidades
                <p>Inventario: {player.inventory} </p>
                <p>Cartas: {player.cards} </p>
                <p>Territorios: {player.territoryCount}</p>
              </li>
            ))}
          </ul>
        </div>
        <div className="plays-container">
          <h2> Resumen de Acciones</h2>
          <ul>
            {usersPlays.map((playArray, arrayIndex) => (
              playArray.map((play, playIndex) => (
                <div key={`${arrayIndex}-${playIndex}`}>{play.log}</div>
              ))
            ))}
          </ul>
        </div>
      </div>
      <div className="my-player-space">
      <h1 style={{ color: getPlayerColor(user.id) }}>Jugador {user.id % 4}</h1>
      <div className="actions-container">
        {selectedTerritory && (
          <div className="action-box">
            <p>Territorio: {selectedTerritory.territoryId}</p>
            <p>Propietario: {selectedTerritory.userId}</p>
            <p>Tropas: {selectedTerritory.troops}</p>
            <input
              type="number"
              value={reinforceUnits}
              onChange={handleReinforceChange}
              placeholder="Cantidad de unidades de refuerzo"
            />
            <button onClick={handleReinforce}>Reforzar</button>
            <button onClick={() => setAttackingTerritory(selectedTerritory)}>Atacar</button>
            <button onClick={() => setMovingTerritory(selectedTerritory)}>Mover</button>
            {isUserInTurn && <button onClick={() => handlePassTurnButton()}>Pasar Turno</button>}
          </div>
        )}
        {attackingTerritory && !targetTerritory && (
          <div className="action-box">
            <p>Territorio atacante: {attackingTerritory.territoryId}</p>
            <p>Selecciona un territorio para atacar</p>
            <button onClick={cancelAttack}>Cancelar</button>
          </div>
        )}
        {attackingTerritory && targetTerritory && !attackConfirmed && (
          <div className="action-box">
            <p>Territorio atacante: {attackingTerritory.territoryId}</p>
            <p>Territorio objetivo: {targetTerritory.territoryId}</p>
            <div>
              <p>Selecciona la cantidad de unidades para atacar:</p>
              <button onClick={() => handleUnitSelection(2)}>2 unidades (1 dado)</button>
              <button onClick={() => handleUnitSelection(3)}>3 unidades (2 dados)</button>
              <button onClick={() => handleUnitSelection(4)}>4 unidades (3 dados)</button>
            </div>
            <p>Unidades seleccionadas: {unitsToAttack}</p>
            <button onClick={handleAttack} disabled={unitsToAttack === 0}>Confirmar ataque</button>
            <button onClick={cancelAttack}>Cancelar</button>
          </div>
        )}
        {attackConfirmed && (
          <div className="action-box">
            <p>Territorio atacante: {attackingTerritory.territoryId}</p>
            <p>Territorio objetivo: {targetTerritory.territoryId}</p>
            <button onClick={rollDice}>Lanzar dados</button>
          </div>
        )}
        {battleResults && (
          <div className="action-box">
            <p>Resultado de la batalla:</p>
            <p>Batallas ganadas: {battleResults.battlesWon}</p>
            <p>Batallas perdidas: {battleResults.battlesLost}</p>
            <div >
            {diceResults.map((result, index) => (
                <img key={index} className='dice-image' src={`/dados/d${result}.png`} alt={`Dice ${result}`} />
            ))}
            </div>
          </div>
        )}
        {movingTerritory && !destinationTerritory && (
          <div className="action-box">
            <p>Territorio origen: {movingTerritory.territoryId}</p>
            <p>Selecciona un territorio destino para mover las unidades</p>
            <input
              type="number"
              value={moveUnits}
              onChange={handleMoveChange}
              placeholder="Cantidad de unidades a mover"
            />
            <button onClick={cancelMove}>Cancelar</button>
          </div>
        )}
        {movingTerritory && destinationTerritory && (
          <div className="action-box">
            <p>Territorio origen: {movingTerritory.territoryId}</p>
            <p>Territorio destino: {destinationTerritory.territoryId}</p>
            <input
              type="number"
              value={moveUnits}
              onChange={handleMoveChange}
              placeholder="Cantidad de unidades a mover"
            />
            <button onClick={handleMove}>Confirmar movimiento</button>
            <button onClick={cancelMove}>Cancelar</button>
          </div>
        )}
      </div>
    </div>
    </div>
  );
};

export default HexMap;
