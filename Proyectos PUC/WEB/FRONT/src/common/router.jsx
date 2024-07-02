import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Landingpage from '../landingpage';
import Login from '../userpages/login';
import Register from '../userpages/register';
import Dashboard from './home';
import Logout from '../userpages/logout';
import LobbyList from '../lobbypages/lobbys';
import CreateLobby from '../lobbypages/createlobby';
import LobbyDetails from '../lobbypages/lobbydetails';
import MyGames from '../gamepages/allgames';
import HexMap from '../gamepages/game';
/* Por Crear
import MapView from '../components/MapView';
import StatsView from '../components/StatsView';
import PlayerControl from '../components/PlayerControl';
      <Route path="/map" element={<MapView />} />
      <Route path="/stats" element={<StatsView />} />
      <Route path="/control" element={<PlayerControl />} />*/

const PageRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<Landingpage />} />
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route path="/home" element={<Dashboard />} /> 
      <Route path="/logout" element={<Logout />} />
      <Route path="/lobbys" element={<LobbyList />} />
      <Route path="/lobby/create" element={<CreateLobby />} />
      <Route path="/lobbys/:id" element={<LobbyDetails />} />
      <Route path="/games" element={<MyGames />} />     
      <Route path="/game/:id" element={<HexMap />} />     
    </Routes>
  );
};

export default PageRoutes;
  