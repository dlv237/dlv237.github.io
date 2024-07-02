import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { useNavigate } from "react-router-dom";
import { Link } from 'react-router-dom';
import UserContext from '../userpages/usercontext';
import './lobbys.css';

function LobbyList() {
  const [lobbies, setLobbies] = useState([]);
  const [error, setError] = useState('');
  const { user, token } = useContext(UserContext);
  const navigate = useNavigate();

  useEffect(() => {
    async function fetchLobbies() {
      try {
        const response = await axios.get('http://localhost:3000/lobbys', { headers: { Authorization: `Bearer ${token}` } });
        setLobbies(response.data);
      } catch (error) {
        console.error('Error al obtener lobbies:', error);
      }
    }
    fetchLobbies();
  }, []);

  const handleJoinLobby = async (lobbyId, password) => {
    try {
      setError(''); 
      const response = await axios.post(`http://localhost:3000/lobbys/${lobbyId}/users`, { userId: user.id, password }
        ,{ headers: { Authorization: `Bearer ${token}` } }
      );
      console.log('Usuario agregado a lobby:', response.data);
      navigate(`/lobbys/${lobbyId}`);
    } catch (error) {
      console.error('Error al unirse a la lobby:', error);
      if (error.response && error.response.data && error.response.data.error) {
        setError(error.response.data.error);
      } else {
        setError('Error al unirse a la lobby');
      }
    }
  };

  return (
    <div className="lobbies_box">
      <h1>Listado de Lobbies</h1>
      {error && <div style={{ color: 'red' }}>{error}</div>}
      <ul>
        {lobbies
          .filter(lobby => lobby.state === "waiting")
          .map(lobby => (
            <li key={lobby.id}>
              <p>Nombre: {lobby.name}</p>
              <p>Cantidad de jugadores: {lobby.cantityPlayers}</p>
              <p>Estado: {lobby.state}</p>
              <p>Privado: {lobby.type ? 'Sí' : 'No'}</p>
              <div className='side-holder'>
              <button className='medium_button' onClick={() => handleJoinLobby(lobby.id, lobby.password)}>Unirse</button>
              <Link to={`/lobbys/${lobby.id}`}>
                <button className='medium_button'>Ver Detalles</button>
              </Link>
              </div>
            </li>
          ))}
      </ul>
    </div>
  );
}

export default LobbyList;