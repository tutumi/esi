require 'nokogumbo'
require 'open-uri'

class CourseScraper

  def self.scrap(id)
    url = "https://uspdigital.usp.br/jupiterweb/jupCursoLista?codcg=#{id}&tipo=N"

    page = Nokogiri.HTML5(open(url)) 

    tabelas = page.css('tr[bgcolor="#658CCF"]')

    courses = []

    tabelas.each do |tabela|
      tds = tabela.ancestors('table').first.css('td')
      (2...tds.size).step(2).each do |index|
        rgx = /codcg=(\d+)&codcur=(\d+)&codhab=(\d+)/.match(tds[index].at_css('a')['href'])
        courses.push({:curso   => tds[index].text.strip,
                      :periodo => tds[index+1].text.strip,
                      :codcg   => rgx[1],
                      :codcur  => rgx[2],
                      :codhab  => rgx[3]})
      end
    end

    return courses
  end

  def self.course_info(page)
    curso = {}
    #duracao = page.css('table')[7].css('tr')
    td_info = page.search("[text()*='Informações Básicas do Currículo']").first
    table_info = td_info.ancestors('table').first
    table_duracao = table_info.next_element.next_element
    duracao = table_duracao.css('tr')
    curso[:duracao] = {
      :ideal => /(\d+) semestres/.match(duracao[0].text)[1].to_i,
      :min   => /(\d+) semestres/.match(duracao[1].text)[1].to_i,
      :max   => /(\d+) semestres/.match(duracao[2].text)[1].to_i
    }

    carga_horaria = table_duracao.next_element.next_element.css('td')
    curso[:carga_horaria] = {
      :obrigatoria => {
          :aula     => carga_horaria[5].text.to_i,
          :trabalho => carga_horaria[6].text.to_i,
      },
      :optativa_livre => {
          :aula     => carga_horaria[9].text.to_i,
          :trabalho => carga_horaria[10].text.to_i,
      },
      :optativa_eletiva => {
          :aula     => carga_horaria[13].text.to_i,
          :trabalho => carga_horaria[14].text.to_i,
      },
      :estagio => carga_horaria[20] ? /(\d+)/.match(carga_horaria[20].text)[1].to_i : 0
    }

    return curso
  end

end

