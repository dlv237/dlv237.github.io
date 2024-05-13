require "test_helper"

class ProductTest < ActiveSupport::TestCase

    test "all parameter good" do
        foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                     'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: 'publicado',
        image: File.new(foto1_path),
        usuario: usuario,
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert result, "Saved all good"
    end

    test "Should not save without nombre" do
        foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                     'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: '',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: 'publicado',
        image: File.new(foto1_path),
        usuario: usuario,
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved withou a name"
    end


    test "Should not save with less than 50char in descripcion" do
        foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                     'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: " cHar",
        estado: 'publicado',
        image: File.new(foto1_path),
        usuario: usuario,
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved with descripcion"
    end

    test "Should not save with more than 1000 char in descripcion" do
        foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                     'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: "Este es un producto altamente versátil y funcional que satisface diversas necesidades.
        Con un diseño elegante y duradero, este producto es la elección perfecta para aquellos que buscan calidad y
        rendimiento. Sus características incluyen una pantalla de alta resolución, una potente capacidad de
        procesamiento, múltiples opciones de conectividad y una batería de larga duración. Además, ofrece una amplia
        gama de aplicaciones y funciones que hacen que sea adecuado para una variedad de usos. Ya sea para trabajar,
        jugar o disfrutar del entretenimiento, este producto ofrece una experiencia excepcional. Su facilidad de uso y
        diseño ergonómico garantizan la comodidad del usuario. Además, se incluyen actualizaciones regulares y soporte
         técnico confiable. Este producto es una inversión que satisfará sus necesidades a largo plazo y se adaptará
         a sus cambiantes requisitos. ¡No busque más allá de este producto excepcional para todas sus necesidades!
           asd  a da  a   a a asd sadasd sad asd as dasd as dasd asd asd asd asd",
        estado: 'publicado',
        image: File.new(foto1_path),
        usuario: usuario,
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved with descripcion"
    end

    test "Should not save without estado" do
      foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                   'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: '',
        image: File.new(foto1_path),
        usuario: usuario,
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved withou a estado"  end

    test "Should not save with wrong estado" do
      foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                   'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: 'No-publicado',
        image: File.new(foto1_path),
        usuario: usuario,
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved without wrong estado"  end


    test "Should not save without image" do
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: 'publicado',
        usuario: usuario,
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved withou a image"  end

    test "Should not save without usuario" do
      foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                   'Captura_de_pantalla_2023-10-25_144043.png')
      Region.new(nombre: "Región Metropolitana")
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: 'publicado',
        image: File.new(foto1_path),
        categoria: categoria,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved withou a usuario"  end

    test "Should not save without categoria" do
      foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                   'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: 'publicado',
        image: File.new(foto1_path),
        usuario: usuario,
        plataforma: plataforma
    )

      result = @producto.save
      assert_not result, "Saved withou a categoria"  end

    test "Should not save without plataforma" do
        foto1_path = Rails.root.join('public','uploads','tmp','1698255683-577715739875855-0001-0825',
                                     'Captura_de_pantalla_2023-10-25_144043.png')
      rm = Region.new(nombre: "Región Metropolitana")
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      categoria = Categoria.new(nombre: "Estrategia")
      categoria.save

      @producto = Product.new(
        nombre: 'PRYEBA',
        descripcion: 'Un smartphone de alta gama con cámara avanzada y rendimiento excepcional.',
        estado: 'publicado',
        image: File.new(foto1_path),
        usuario: usuario,
        categoria: categoria
    )

      result = @producto.save
      assert_not result, "Saved withou a plataforma"
    end

    teardown do
      # normalmente es buena idea resetear el cache
          Rails.cache.clear
      end

end
