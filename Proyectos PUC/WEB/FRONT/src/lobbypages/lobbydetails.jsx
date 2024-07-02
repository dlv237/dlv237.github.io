import React, { useState, useEffect, useContext } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import UserContext from '../userpages/usercontext';
import axios from 'axios';

function LobbyDetails() {
  const { id } = useParams();
  const [lobby, setLobby] = useState(null);
  const [players, setPlayers] = useState([]);
  const [isUserInLobby, setIsUserInLobby] = useState(false);
  const [error, setError] = useState(null);
  const { user, token } = useContext(UserContext);
  const navigate = useNavigate();

  useEffect(() => {
    async function fetchLobbyDetails() {
      try {
        const lobbyResponse = await axios.get(`http://localhost:3000/lobbys/${id}`, { headers: { Authorization: `Bearer ${token}` } });
        setLobby(lobbyResponse.data);

        const playersResponse = await axios.get(`http://localhost:3000/lobbys/${id}/users`, { headers: { Authorization: `Bearer ${token}` } });
        setPlayers(playersResponse.data);

        const userInLobby = playersResponse.data.some(player => player.userId === user.id);
        setIsUserInLobby(userInLobby);
      } catch (error) {
        console.error('Error al obtener detalles del lobby:', error);
      }
    }
    fetchLobbyDetails();
  }, [id, user.id]);

  const handlePlayerStateChange = async (newState) => {
    try {
      const response = await axios.patch(`http://localhost:3000/lobbys/${id}/users/${user.id}`, { state: newState }, { headers: { Authorization: `Bearer ${token}` }});
      console.log('Estado del jugador actualizado:', response.data);
      const updatedPlayersResponse = await axios.get(`http://localhost:3000/lobbys/${id}/users`, { headers: { Authorization: `Bearer ${token}` } });
      setPlayers(updatedPlayersResponse.data);
    } catch (error) {
      console.error('Error al cambiar el estado del jugador:', error);
    }
  };

  const handleLeaveLobby = async () => {
    try {
      await axios.delete(`http://localhost:3000/lobbys/${id}/users/${user.id}`, { headers: { Authorization: `Bearer ${token}` } });
      console.log('Usuario eliminado del lobby');
      navigate('/lobbys');
    } catch (error) {
      console.error('Error al salir del lobby:', error);
    }
  };

  const handleStartGame = async () => {
    try {
      setError(null);
      const response = await axios.patch(`http://localhost:3000/lobbys/${id}`,{}, { headers: { Authorization: `Bearer ${token}` } });
      console.log('Juego iniciado:', response.data);
      const map = await axios.get(`http://localhost:3000/game/${lobby.id}`, { headers: { Authorization: `Bearer ${token}` } })
      navigate(`/game/${id}`);
    } catch (error) {
      console.error('Error al iniciar el juego:', error);
      setError(error.response.data.error);
    }
  };

  if (!lobby || players.length === 0) {
    return <div>Cargando detalles del lobby...</div>;
  }

  return (
    <div>
      <h1>Detalles del Lobby</h1>
      <p>ID del Lobby: {lobby.id}</p>
      <p>Nombre del Lobby: {lobby.name}</p>
      <p>Estado del Lobby: {lobby.state}</p>
      <p>Cantidad de jugadores: {lobby.cantityPlayers}</p>
      <h2>Jugadores:</h2>
      <ul>
        {players.map((player, index) => (
          <li key={player.id}>
            Jugador {index + 1}: {player.username} - Estado: {player.userState}
          </li>
        ))}
      </ul>
      {isUserInLobby && (
        <div>
          <button onClick={() => handlePlayerStateChange('listo')}>Marcar como listo</button>
          <button onClick={() => handlePlayerStateChange('waiting')}>Marcar como esperando</button>
          <button onClick={handleLeaveLobby}>Salir del Lobby</button>
        </div>
      )}
      {isUserInLobby && lobby.cantityPlayers > 1 && (
        <div>
          <button onClick={handleStartGame}>Comenzar Juego</button>
        </div>
      )}
      {error && <p style={{ color: 'red' }}>{error}</p>}
    </div>
  );
}

export default LobbyDetails;