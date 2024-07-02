import React, { useState, useContext, useEffect } from 'react';
import axios from 'axios';
import { useNavigate } from "react-router-dom";
import UserContext from '../userpages/usercontext';

function MyGames(){
    const {user, token} = useContext(UserContext);
    const navigate = useNavigate();
    const [games, setGames] = useState([]);

    useEffect(() => {
        async function fetchGames() {
            try {
                const response = await axios.get('http://3.19.16.195:3000/game/users/' + user.id,
                { headers: { Authorization: `Bearer ${token}` } }
                );
                setGames(response.data);
            } catch (error) {
                console.error('Error al obtener juegos:', error);
            }
        }
        fetchGames();
    }, []);

    return (
        <div>
          <h1>Mis Juegos</h1>
          <ul>
            {games.map((game, index) => (
              <li key={game.id}>
                <p>Juego {index + 1}</p>
                <p>Turn: {game.turn}</p>
                <p>Unidades en inventario: {game.unity_inventary}</p>
                <p>Unidades desplegadas: {game.unity_count}</p>
                <p>Cantidad de cartas: {game.cards_count}</p>
                <button onClick={() => navigate(`/game/${game.lobbyId}`)}>Ver Detalles</button>
              </li>
            ))}
          </ul>
        </div>
      );
    }
    
    export default MyGames;