import React, { useState, useContext } from 'react';
import axios from 'axios';
import { useNavigate } from "react-router-dom";
import UserContext from '../userpages/usercontext';
import '../index.css';
import './createlobby.css'; 

function CreateLobby() {
  const { user, token } = useContext(UserContext);
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    host_id: user.id,
    type: false,
    password: '',
    name:'Lobby de' + user.nickname  // Establece el nombre del lobby como el nickname del usuario por defecto
  });

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleCheckboxChange = (e) => {
    const { name, checked } = e.target;
    setFormData({
      ...formData,
      [name]: checked
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://3.19.16.195:3000/lobbys', formData
        , { headers: { Authorization: `Bearer ${token}` } }
      );
      console.log('Lobby creado:', response.data);
      navigate('/lobbys');
    } catch (error) {
      console.error('Error al crear lobby:', error);
    }
  };

  return (
    <div className="container">
  <div className="screen">
    <h1>Crear Lobby</h1>
    <form onSubmit={handleSubmit}>
      <div className="form-group"> 
        <label htmlFor="name">Nombre del Lobby:</label>
        <input type="text" id="name" name="name" value={formData.name} onChange={handleChange} />
      </div>
      <div className="form-group"> 
        <label htmlFor="private">Privado</label>
        <input type="checkbox" id="private" name="private" checked={formData.type} onChange={handleCheckboxChange} />
      </div>
      {formData.private && (
        <div className="form-group">
          <label htmlFor="password">Contraseña:</label>
          <input type="password" id="password" name="password" value={formData.password} onChange={handleChange} />
        </div>
      )}
      <button className="medium_button" type="submit">Crear Lobby</button>
    </form>
  </div>
</div>

  );
}

export default CreateLobby;