import React, { useContext } from 'react';
import { Link } from 'react-router-dom';
import UserContext from '../userpages/usercontext';
import './navbar.css';

function Navbar() {
    const { user } = useContext(UserContext);
  
    return (
      <nav>
 {user && (
        <>
          <Link to="/home">Inicio</Link>
          <Link to="/lobbys">Lobbys</Link>
          <Link to="/lobby/create">Crear lobby</Link>
          <Link to ="/games">Mis juegos</Link>	
        </>
      )}
        {!user ? (
          <>
            <Link to="/login">Iniciar sesión</Link>
            <Link to="/register">Registrarse</Link>
          </>
        ) : (
          <Link to="/logout">Cerrar sesión</Link>
        )}
      </nav>
    );
  }
  
  export default Navbar;