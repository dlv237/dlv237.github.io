# LRWebServices_frontend

## Levantar la app

Para levantar el front-end, se requiere en primer lugar que el back-end esté funcionando e instanciado como corresponde. Esto, según lo establecido en la documentación del repositorio del back-end de LRWebServices. 
Con esto asegurado, se deben ejecutar los siguientes comandos.

    npm install 
    npm run dev

El primero instala las dependencias necesarias del proyecto, y el segundo corre la app react en modo desarrollo (no en producción).

Si la api esta corriendo, las conexiones a la api son gestionadas mediante los distintos archivos .jsx del proyecto front-end. Pero, todas estas rutas estan protegidas mediante json web tokens, entonces, cuando un usuario inicia sesión, la api retorna un token que tiene una duración de 1 hora, y este es guardado en un estado global al igual que el usuario (modelo del usuario). Con este token, todas las llamadas a axios GET, POST, PATCH, etc, se manejan mediante un header de Key Authorization y un value Bearer {token}, lo cual asegura que el acceso a los endpoints sean manejados por el front-end de manera exclusiva.

## Contenido del proyecto en html y .css

En el proyecto se incluyen varios archvos .css que son correspondientes a cada grupo de estilos, estos son
        game.css
        lobbus.css
        createlobby.css
        login.css
        register.css

Se incluyen ademas, vistas estaticas como dos landing que dan la bienvenida al usuario, poseen elementos centrados, margenes ajustados, botones reactivos, hoover, tipografia y cambios en tamaños de letras.
Para esto se hace uso de flexbox y display flex, que permite ajustar los elementos en posiciones más agradables para el usuario.

Se realizó un primer desarrollo del juego, este iniciando por busquedas y creación de lobbys y de vista internas de lobbys, desde la cual se puede dar inicio al juego. 

El juego contiene toda la información relevante e inicial requerida, como la cantidad de tropas id del usuario, nicknames, estado actual, etc. Pero más importante, el tablero y casillas que estan asignadas a cada uno. En esta entrega fueron implementados las dos funcionalidades básicas prometidas; agregar unidades, y mover unidades.
