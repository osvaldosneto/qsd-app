class Category
    attr_accessor :nome, :id_category

    def initialize(nome, id_category)
        @nome = nome
        @id_category = id_category
    end

    def self.all
        categorias_list = []
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        categorias = db.execute "SELECT * FROM Category"
        db.close
        categorias.each do |row|
            categorias_list << Category.new(row[1], row[0])
        end
        return categorias_list
    end

    def self.listCategorias
        categorias = Category.all
        categorias.each do |categoria|
            puts '#' + categoria.id_category.to_s + " - " + categoria.nome
        end
    end

    def self.getCategoryById(id)
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        categoria = db.execute "SELECT * FROM Category where id_category='#{id}'"
        db.close
        return Category.new(categoria[0][1], categoria[0][0])
    end

end
