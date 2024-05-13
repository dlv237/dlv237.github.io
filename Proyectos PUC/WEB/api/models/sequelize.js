const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('web', 'prouser', 'admin1214', {
  host: 'localhost',
  dialect: 'postgres',
  logging: console.log, 
});

module.exports = sequelize;
