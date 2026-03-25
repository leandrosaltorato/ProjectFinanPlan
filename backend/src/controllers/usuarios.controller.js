const prisma = require("../data/prisma");
const { cryptPassword } = require("../services/security.service");

const cadastrar = async (req, res) => {
    const data = req.body;

    data.senha = cryptPassword(data.senha);

    const item = await prisma.usuarios.create({
        data
    });

    delete item.senha;

    res.json(item).status(201).end();
};

const listar = async (req, res) => {
    const lista = await prisma.usuarios.findMany({
        omit: {
            senha: true
        }
    });

    res.json(lista).status(200).end();
};

const buscar = async (req, res) => {
    const { id } = req.params;
    
    const item = await prisma.usuarios.findUnique({
        where: { id : Number(id) }
    });

    res.json(item).status(200).end();
};

const atualizar = async (req, res) => {
    const { id } = req.params;
    const dados = req.body;
    
    const item = await prisma.usuarios.update({
        where: { id : Number(id) },
        data: dados
    });

    res.json(item).status(200).end();
};

const excluir = async (req, res) => {
    const { id } = req.params;
    
    const item = await prisma.usuarios.delete({
        where: { id : Number(id) }
    });

    res.json(item).status(200).end();
};

module.exports = {
    cadastrar,
    listar,
    buscar,
    atualizar,
    excluir
}
