import React, { useContext } from 'react';
import UserContext from '../userpages/usercontext';
import './home.css'; // Importar los estilos CSS

function Dashboard() {
  const { user } = useContext(UserContext);
  console.log(user);

  return (
    
    <div className="dashboard">
      <div className='box'>
      <h1>Menu Principal</h1>
      {user && <p>Bienvenido, {user.nickname}!</p>}
    </div>
    </div>
  );
}

export default Dashboard;
