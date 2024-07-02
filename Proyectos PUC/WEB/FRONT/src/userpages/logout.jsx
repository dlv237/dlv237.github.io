import React, { useContext, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import UserContext from './usercontext';

function Logout() {
  const { user, logout } = useContext(UserContext);
  const navigate = useNavigate();

  useEffect(() => {
    const performLogout = async () => {
      try {
        if (user && user.email) {
          await axios.patch(`http://localhost:3000/users/${user.email}`, {
            is_logged: false
          });
        }
      } catch (error) {
        console.error('Error al cerrar sesión:', error);
      } finally {
        logout();
        navigate('/');
      }
    };

    performLogout();
  }, [user, logout, navigate]);

  return null; 
}

export default Logout;