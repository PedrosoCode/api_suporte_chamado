const Sequelize = require("sequelize");
const conns = new Sequelize(
 'app_suporte',
 'root',
 'root',
  {
    host: '127.0.0.1',
    dialect: 'mysql'
  }
);

conns.authenticate().then(() => {
   console.log('Conexão bem sucedida!. =D ');
}).catch((error) => {
   console.error('erro ao conectar no BD :( ', error);
});

module.exports = conns;