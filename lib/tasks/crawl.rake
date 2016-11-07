require_relative "../crawler/jupiter.rb"

namespace :crawl do
  desc "Adiciona todos os cursos e disciplinas no arquivo lib/crawler/jupiter.json"
  task :jupiter_to_file  do
    JupiterCrawler.crawl_to_file
  end

  desc "Carrega as informações do json contido em lib/crawler/jupiter.json e adiciona no banco de dados"
  task json_to_db: :environment do
    JupiterCrawler.json_to_db
  end
end
