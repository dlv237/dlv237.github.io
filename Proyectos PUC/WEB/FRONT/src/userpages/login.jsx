import React, { useState, useContext } from 'react';
import "../index.css"
import "./login.css";
import { useNavigate } from "react-router-dom";
import axios from 'axios';
import UserContext from './usercontext';
import '../common/buttonStyles.css';

function Login() {
  const navigate = useNavigate();
  const { setUser, setToken } = useContext(UserContext); 
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      console.log(password);
      const response = await axios.post(`http://localhost:3000/users/${email}`, {password: password});
      console.log(response.data)
      if (response.status === 200) {
        setUser(response.data.user); 
        setToken(response.data.token);
        navigate('/home');
      } else {
        setError('Correo electrónico o contraseña incorrectos');
      }
    } catch (err) {
      console.log(err);
      setError('Hubo un problema al iniciar sesión. Por favor, inténtalo de nuevo.');
    }
  };

  return (
    <div className="landing-container">
      <div >
        
        <div className="big_container">
          <div className="container">
            <div className="screen">
              <div className="screen__content">
                <h2 className="login-title">Log In</h2>
                <form className="register" onSubmit={handleLogin}>
                  <div className="login__field">
                    <input
                      type="email"
                      className="login__input"
                      placeholder="Mail"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                    />
                  </div>
                  <div className="login__field">
                    <input
                      type="password"
                      className="login__input"
                      placeholder="Contraseña"
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      required
                    />
                  </div>
                  {error && <p className="error-message">{error}</p>}
                  <div className="login-buttons-container">
                    <button type="submit" className="medium_button">
                      <span className="button__text">Continuar</span>
                    </button>
                    <div className="break_small"></div>
                    <button
                      type="button"
                      className="medium_button"
                      onClick={() => navigate("/")}
                    >
                      <span className="button__text">Volver</span>
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Login;
