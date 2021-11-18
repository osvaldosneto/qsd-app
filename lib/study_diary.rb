require_relative 'category.rb'
require_relative 'studyItem'
require 'sqlite3'

entrada = 0

def cadastrarItem()
    printf("Digite o título de seu item de estudo:")
    nome = gets.chomp()
    printf("Escolha uma categoria para seu item de estudo:\n")
    Category.listCategorias
    categoria_id = gets.chomp()
    printf("Escreva uma descrição para o item:")
    descricao = gets.chomp()
    studyItem = StudyItem.new(nome, Category.getCategoryById(categoria_id), 1, descricao)
    studyItem.save_to_db
    confirmaContinue()
end

def confirmaContinue()
    puts ''
    puts "Pressione qualquer tecla para continuar"
    gets.chomp()
end

def verTodosItens()
    StudyItem.listItens(StudyItem.all)
    confirmaContinue()
end

def buscarItemEstudo()
    printf("Digite uma palavra para procurar:")
    search = gets.chomp()
    itens = StudyItem.findByNomeorDescription(search)
    puts ''
    puts 'Foram encontrados ' + itens.length().to_s + ' itens:'
    itens.each_with_index do |item, index|
        puts "#" + (index+1).to_s + " - " + item.nome + " - " + item.category.nome
    end
    confirmaContinue()
end

def listarPorCategoria()
    printf("Escolha uma categoria para listar seus itens:\n")
    Category.listCategorias
    categoria_id = gets.chomp()
    StudyItem.listItens(StudyItem.findByCategoriaId(categoria_id))
    confirmaContinue()
end




while entrada != '5' do
    puts '[1] Cadastrar um item para estudar'
    puts '[2] Ver todos os itens cadastrados'
    puts '[3] Listar por categorias'
    puts '[4] Buscar um item de estudo'
    puts '[5] Sair'
    printf('Escolha uma opção:')
    entrada = gets.chomp()
    
    case entrada
    when '1'
        cadastrarItem()
    when '2'
        verTodosItens()
    when '3'
        listarPorCategoria()
    when '4'
        buscarItemEstudo()
    when '4'
        puts 'Obrigado por usar o Diário de Estudos!!'
    else
        puts 'Opção Inválida'
    end
end

