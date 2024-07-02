import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';
import { UserProvider } from './userpages/usercontext';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <UserProvider>
    <div className="background-image-container"> 
      <App />
    </div>
    </UserProvider>
  </React.StrictMode>,
);