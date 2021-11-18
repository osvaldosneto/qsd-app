require_relative 'category.rb'

class StudyItem
    attr_accessor :nome, :id_studyitem, :category, :status, :descricao

    def initialize(nome, category, status, descricao)
        @nome = nome
        @category = category
        @status = 1
        @descricao = descricao
    end

    def save_to_db
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        db.execute "INSERT INTO StudyItem (nome, status_item, category_id, descricao) 
                    VALUES('#{nome}', #{status} , #{category.id_category}, '#{descricao}')"
        db.close
        puts "Item " + nome + " cadastrado na categoria " + category.nome
    end

    def self.all
        studyItens = []
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        itens = db.execute "SELECT * from StudyItem 
                            INNER JOIN Category 
                            on StudyItem.category_id=Category.id_category"
        itens.each do |item|
            studyItens << StudyItem.new(item[1], Category.getCategoryById(item[5]), item[3], item[2])
        end
        studyItens
    end

    def self.findByUndone
        studyItens = []
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        itens = db.execute "SELECT * from StudyItem 
                            INNER JOIN Category 
                            on StudyItem.category_id=Category.id_category
                            WHERE StudyItem.status_item=1"
        itens.each do |item|
            sutudyItem = StudyItem.new(item[1], Category.getCategoryById(item[5]), item[3], item[2])
            sutudyItem.id_studyitem = item[0]
            studyItens << sutudyItem
        end
        studyItens
    end

    def self.listItens(itens)
        itens.each do |item|
            puts item.nome + " - " + item.category.nome + " - " + item.descricao
        end
    end

    def self.listItensWithId(itens)
        itens.each do |item|
            puts "[" + item.id_studyitem.to_s + "] " + item.nome + " - " + item.category.nome + " - " + item.descricao
        end
    end

    def self.findByNomeorDescription(nome)
        studyItens = []
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        itens = db.execute "SELECT * from StudyItem 
                            INNER JOIN Category 
                            on StudyItem.category_id=Category.id_category
                            WHERE StudyItem.nome LIKE '%#{nome}%' or StudyItem.descricao LIKE '%#{nome}%'"
        itens.each do |item|
            studyItens << StudyItem.new(item[1], Category.getCategoryById(item[5]), item[3], item[2])
        end
        studyItens
    end

    def self.findByCategoriaId(categoria_id)
        studyItens = []
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        itens = db.execute "SELECT * from StudyItem 
                            INNER JOIN Category 
                            on StudyItem.category_id=Category.id_category
                            WHERE Category.id_category=#{categoria_id}"
        itens.each do |item|
            studyItens << StudyItem.new(item[1], Category.getCategoryById(item[5]), item[3], item[2])
        end
        studyItens
    end

    def self.setStatusDone(id_item)
        db = SQLite3::Database.open "/Users/osvaldosneto/Desktop/qsd-app/database.db"
        db.execute "update StudyItem set status_item = 0 where id_studyitem = #{id_item}"
    end

end
