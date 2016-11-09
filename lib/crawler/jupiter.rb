require 'nokogumbo'
require 'open-uri'
require 'json'
require_relative "../scraper/unit.rb"
require_relative "../scraper/course.rb"
require_relative "../scraper/subject.rb"

class JupiterCrawler
  def self.crawl
    puts "Obtendo dados das unidades..."
    
    units = UnitScraper.scrap

    courses = []
    
    units.each do |unit|
      puts "Obtendo dados da unidade #{unit}..."
      courses.concat(CourseScraper.scrap(unit))
    end

    courses.each do |course|
      jupiterurl = "https://uspdigital.usp.br/jupiterweb/listarGradeCurricular?codcg=#{course[:codcg]}&codcur=#{course[:codcur]}&codhab=#{course[:codhab]}&tipo=N"

      # Usando HTML5 gumbo-parser do Google para contornar o problema de </tr> sem <tr> correspondente nos requisitos das optativas.
      page = Nokogiri.HTML5(open(jupiterurl))
      begin
        course.merge!(CourseScraper.course_info(page))
        course[:disciplinas] = SubjectScraper.scrap(page)
      rescue # => error
        #puts $!
        #puts $!.backtrace
        puts jupiterurl
        puts "Erro no curso #{course[:curso]}"
        courses.delete(course)
      end
    end

    return courses
  end

  def self.crawl_to_file
    courses = self.crawl
    File.open("lib/crawler/jupiter.json","w") do |f|
      f.write(courses.to_json)
    end
  end

  def self.json_to_db
    courses = JSON.parse(File.read("lib/crawler/jupiter.json"))
    ActiveRecord::Base.transaction do
      courses.each do |course|
        puts "Adicionando #{course['curso']} (#{course['periodo']})..."
        curso = self.novo_curso(course)
        puts 'Adicionando disciplinas do curso...'
        course["disciplinas"].each do |semestre, disciplinas|
          disciplinas.each do |disciplina|
            disciplina_obj = self.adiciona_disciplina(disciplina)
            Curriculum.create(course: curso, subject: disciplina_obj, semestre: semestre.to_i, tipo: disciplina["tipo"])
            self.adiciona_requisitos(disciplina["requisitos"], disciplina_obj, curso)
          end
        end
      end
    end
  end

  def self.novo_curso(course)
    return Course.create(nome: course["curso"],
                         codcg: course["codcg"],
                         codcur: course["codcur"],
                         codhab: course["codhab"],
                         duracao_min: course["duracao"]["min"],
                         duracao_ideal: course["duracao"]["ideal"],
                         duracao_max: course["duracao"]["max"],
                         ch_obrigatoria_aula: course["carga_horaria"]["obrigatoria"]["aula"],
                         ch_obrigatoria_trab: course["carga_horaria"]["obrigatoria"]["trabalho"],
                         ch_eletiva_aula: course["carga_horaria"]["optativa_livre"]["aula"],
                         ch_eletiva_trab: course["carga_horaria"]["optativa_livre"]["trabalho"],
                         ch_livre_aula: course["carga_horaria"]["optativa_eletiva"]["aula"],
                         ch_livre_trab: course["carga_horaria"]["optativa_eletiva"]["trabalho"],
                         ch_estagio: course["carga_horaria"]["estagio"],
                         periodo: course["periodo"])

  end

  def self.adiciona_requisitos(reqs, disciplina, curso)
    reqs.each do |tipo, requisitos|
      requisitos.each do |requisito|
        Requisite.create(disciplina: disciplina, 
                         requisito: Subject.where(codigo: requisito).first, 
                         tipo: tipo, 
                         course: curso)
      end
    end
  end

  def self.adiciona_disciplina(disciplina)
    return Subject.create_with(nome: disciplina["nome"],
                               credito_aula: disciplina["credito_aula"],
                               credito_trab: disciplina["credito_trab"],
                               carga_horaria: disciplina["carga_horaria"],
                               carga_estagio: disciplina["carga_estagio"],
                               carga_pratica: disciplina["carga_pratica"],
                               carga_aaca: disciplina["carga_aaca"])
                  .find_or_create_by(codigo: disciplina["codigo"])
  end

end
