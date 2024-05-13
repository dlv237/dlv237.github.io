# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#REGIONES
r15=Region.create(nombre: "Región de Arica y Parinacota")
r1=Region.create(nombre: "Región de Tarapacá")
r2=Region.create(nombre: "Región de Antofagasta")
r3=Region.create(nombre: "Región de Atacama")
r4=Region.create(nombre: "Región de Coquimbo")
r5=Region.create(nombre: "Región de Valparaíso")
rm=Region.create(nombre: "Región Metropolitana")
r6=Region.create(nombre: "Región de O’Higgins")
r7=Region.create(nombre: "Región del Maule")
r16=Region.create(nombre: "Región del Ñuble")
r8=Region.create(nombre: "Región del Biobío")
r9=Region.create(nombre: "Región de La Araucanía")
r14=Region.create(nombre: "Región de Los Ríos")
r10=Region.create(nombre: "Región de Los Lagos")
r11=Region.create(nombre: "Región de Aysén")
r12=Region.create(nombre: "Región de Magallanes")


Usuario.create!(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
Usuario.create!(email:"pablo@gmail.com", nombre:"Pablo", password:"pablo123", region: r16)
Usuario.create!(email:"juan@gmail.com", nombre:"Juan", password:"juan123", region: r5)



##CATEGORIAS
cat_deportes = Categoria.create(nombre: "Deportes")
cat_mundo_abierto = Categoria.create(nombre: "Mundo Abierto")
Categoria.create(nombre: "Arcade")
Categoria.create(nombre: "Carreras")
cat_simulacion = Categoria.create(nombre: "Simulación")
Categoria.create(nombre: "FPS")
Categoria.create(nombre: "RPG")
Categoria.create(nombre: "Estrategia")
Categoria.create(nombre: "Pelea")
Categoria.create(nombre: "Aventura")
Categoria.create(nombre: "Otra")

#PLATAFORMAS
plataforma_2 = Plataforma.create(nombre: "PlayStation 5")
plataforma_1 = Plataforma.create(nombre: "PlayStation 4")
plataforma_3 = Plataforma.create(nombre: "PlayStation 3")
Plataforma.create(nombre: "PlayStation 2")
Plataforma.create(nombre: "PlayStation 1")
Plataforma.create(nombre: "Xbox Series S|X")
Plataforma.create(nombre: "Xbox 360")
Plataforma.create(nombre: "Xbox ")
Plataforma.create(nombre: "Nintendo Switch")
Plataforma.create(nombre: "Nintendo Wii U")
Plataforma.create(nombre: "Nintendo Wii")
Plataforma.create(nombre: "Otra")



usuario1 = Usuario.find_by(email: "pedro@gmail.com")
usuario2 = Usuario.find_by(email: "pablo@gmail.com")
usuario3 = Usuario.find_by(email: "juan@gmail.com")

foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825', 'Captura_de_pantalla_2023-10-25_144043.png')
foto2_path = Rails.root.join('public','uploads','tmp','1698242803-786479119477429-0002-3383','henry.jpeg')
foto3_path = Rails.root.join('public','uploads','tmp','1698242803-786479119477429-0002-3383','henry.jpeg')
Product.create!(nombre: 'Fifa 18 - PS4', descripcion: 'Descripción del Producto 1 este es un producto generico el cual se encuentra publicado por xxddd', estado: 'publicado', image: File.new(foto1_path), usuario: usuario1, categoria: cat_deportes, plataforma: plataforma_1)
Product.create!(nombre: 'Henry Cavil ????', descripcion: 'Superman Estado unico ano 1992 el unico incomparable henry' , estado: 'publicado', image: File.new(foto2_path), usuario: usuario2, categoria: cat_mundo_abierto, plataforma: plataforma_2)
Product.create!(nombre: 'Henry Cavil de nuevo????', descripcion: 'The Witcher, (la pereza de añadir fotos de juegos xd) the witcher juegazo, me encatna', estado: 'publicado', image: File.new(foto3_path), usuario: usuario3, categoria: cat_simulacion, plataforma: plataforma_1)
Admin.create!(email: "admin@gmail.com", password: "admin123")


usuario1 = Usuario.find_by(email: "pedro@gmail.com")
usuario2 = Usuario.find_by(email: "pablo@gmail.com")

Room.create!(name: "Prueba entre dos", usuario_1: usuario1, usuario_2: usuario2, is_private: true)
Room.create!(name: "Publico", usuario_1: usuario1, usuario_2: usuario2, is_private: true)