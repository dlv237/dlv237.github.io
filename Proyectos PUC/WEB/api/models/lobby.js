const sequelize = require('./sequelize');
const { DataTypes } = require('sequelize');
const User = require('./user');

const Lobby = sequelize.define('Lobby', {
    type: {
      type: DataTypes.BOOLEAN,
      allowNull: false 
    },
    state: {
      type: DataTypes.STRING,
      allowNull: false
    },
    host_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'Users',
        key: 'id'
      }
    },
    password: {
      type: DataTypes.STRING,
      allowNull: true
    }
  });
  
Lobby.belongsTo(User, { foreignKey: 'host_id' });

module.exports = Lobby;
