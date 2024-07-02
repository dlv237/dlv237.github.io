import "./register.css";
import { useNavigate } from "react-router-dom";
import { useState } from "react";
import axios from "axios";
import '../common/buttonStyles.css';
import "../index.css"
function Register() {
  const navigate = useNavigate();

  const [user, setUser] = useState({
    nickname: "",
    email: "",
    password: ""
  });

  const handleSubmit = async (e) => {
    e.preventDefault();
    console.log(user);
    try {
      const response = await axios.post(
        "http://3.19.16.195:3000/users",
        user,
      );
      if (response.status === 200) {
        navigate("/");
      } else {
        console.log("error al registrar, si llego reponse");
      }
    } catch (error) {
      console.error("Error al registrar:", error);
    }
  };

  const handleChange = (e) => {
    setUser({ ...user, [e.target.name]: e.target.value });
  };

  return (
    <div className="landing-container">
      <div className="landing-content">
        <div className="landing-left-container"></div>
        <div className="landing-right-container">
          <div className="container">
            <div className="screen">
              <div className="screen__content">
                <h2 className="register-title">SIGN UP</h2>
                <form className="register" onSubmit={handleSubmit}>
                  <div className="register__field">
                    <input
                      type="text"
                      className="login__input"
                      placeholder="Nombre"
                      name="nickname"
                      value={user.nickname}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="register__field">
                    <input
                      type="email"
                      className="login__input"
                      placeholder="Mail"
                      name="email"
                      value={user.email}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="register__field">
                    <input
                      type="password"
                      className="login__input"
                      placeholder="Contraseña"
                      name="password"
                      value={user.password}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="login-buttons-container">
                    <button type="submit" className="medium_button">
                      <span className="button__text">Continuar</span>
                    </button>
                    <button
                      className="medium_button login__submit--secondary"
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

export default Register;
