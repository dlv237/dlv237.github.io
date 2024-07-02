import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router } from 'react-router-dom';
import PageRoutes from './common/router';
import Navbar from './common/navbar';
import './index.css';
import { UserProvider } from './userpages/usercontext';
import './App.css'
const images = [
  'assets/Mechs1.png',
  // Agrega más nombres de imágenes según sea necesario
];

function App() {
  
  return (
    <UserProvider>
      <Router>
        <Navbar />
        <div className="background-image-container">
          <PageRoutes />
        </div>
      </Router>
    </UserProvider>
  );
}

export default App;