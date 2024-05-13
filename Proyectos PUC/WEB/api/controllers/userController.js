const User = require('../models/user');

async function createUser(ctx) {
    console.log('Crear usuario');
    console.log(ctx.request.body);
    try {
        const { nickname, email, password } = ctx.request.body;
        
        // Verificar si ya existe un usuario con el mismo email
        const existingUserWithEmail = await User.findOne({ where: { email } });
        if (existingUserWithEmail) {
            ctx.status = 400;
            ctx.body = { error: 'Ya existe un usuario con este email' };
            return;
        }

        // Verificar si ya existe un usuario con el mismo nickname
        const existingUserWithNickname = await User.findOne({ where: { nickname } });
        if (existingUserWithNickname) {
            ctx.status = 400;
            ctx.body = { error: 'Ya existe un usuario con este nickname' };
            return;
        }

        // Si no existe un usuario, creamos uno nuevo
        const user = await User.create({ nickname, email, password });
        ctx.status = 201;
        ctx.body = user;
        console.log('Usuario creado:', user);
    } catch (error) {
        console.error('Error al crear usuario:', error);
        ctx.status = 500;
        ctx.body = { error: 'Error al crear usuario' };
    }
}


async function getUsers(ctx) {
    console.log('Obtener todos los usuarios');
    try {
        const users = await User.findAll();
        ctx.status = 200;
        ctx.body = users;
        console.log('Usuarios encontrados:', users);
    } catch (error) {
        console.error('Error al obtener usuarios:', error);
        ctx.status = 500;
        ctx.body = { error: 'Error al obtener usuarios' };
    }
}

module.exports = {
    createUser,
    getUsers
};