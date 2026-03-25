require("dotenv").config();

const express = require("express");
const cors = require("cors");

const app = express();

app.use(express.json());
app.use(cors());

const lembretesRoutes = require('./src/routes/lembretes.routes');

app.use('/lembretes', lembretesRoutes);


const previsaosaldoRoutes = require('./src/routes/previsaosaldo.routes');

app.use('/previsaosaldo', previsaosaldoRoutes);


const categoriaRoutes = require('./src/routes/categoria.routes');

app.use('/categoria', categoriaRoutes);


const transacoesRoutes = require('./src/routes/transacoes.routes');

app.use('/transacoes', transacoesRoutes);


const usuarioscontrolesRoutes = require('./src/routes/usuarioscontroles.routes');

app.use('/usuarioscontroles', usuarioscontrolesRoutes);


const controleRoutes = require('./src/routes/controle.routes');

app.use('/controle', controleRoutes);


const usuariosRoutes = require('./src/routes/usuarios.routes');

app.use('/usuarios', usuariosRoutes);


const administradoresRoutes = require('./src/routes/administradores.routes');

app.use('/administradores', administradoresRoutes);

// importar rotas e aplica-las

// fim das rotas


app.listen(process.env.PORT_APP, () => {
    console.log("Online na porta " + process.env.PORT_APP);
});