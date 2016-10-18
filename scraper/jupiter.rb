require 'nokogiri'
require 'nokogumbo'
require 'open-uri'
require 'json'

# Todos os cursos da USP estão disponíveis em: https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D
jupiterurl = "https://uspdigital.usp.br/jupiterweb/listarGradeCurricular?codcg=86&codcur=86200&codhab=204&tipo=N"

# Usando HTML5 gumbo-parser do Google para contornar o problema de </tr> sem <tr> correspondente nos requisitos das optativas.
page = Nokogiri.HTML5(open(jupiterurl)) 

# Informações Básicas do Currículo
curso = { :nome => page.css('table')[5].css('span').text[6..-1] }

duracao = page.css('table')[7].css('tr')
curso[:duracao] = {
  :ideal => /(\d+) semestres/.match(duracao[0].text)[1],
  :min   => /(\d+) semestres/.match(duracao[1].text)[1],
  :max   => /(\d+) semestres/.match(duracao[2].text)[1]
}

carga_horaria = page.css('table')[8].css('td')
curso[:carga_horaria] = {
  :obrigatoria => {
      :aula     => carga_horaria[5].text,
      :trabalho => carga_horaria[6].text,
  },
  :optativa_livre => {
      :aula     => carga_horaria[9].text,
      :trabalho => carga_horaria[10].text,
  },
  :optativa_eletiva => {
      :aula     => carga_horaria[13].text,
      :trabalho => carga_horaria[14].text,
  },
  :estagio => /(\d+)/.match(carga_horaria[20].text)[1]
}

# Seletor que retorna as linhas da tabela com as disciplinas e seus requisitos.
trs = page.css('table table table:last-child table tr')

semestre = 1
obrigatoria = false
curso[:disciplinas]  = {}

trs.each do |tr|
  case tr['bgcolor']
    when '#FFFFFF' # A linha representa uma disciplina.
      curso[:disciplinas][semestre] = [] if !curso[:disciplinas].key?(semestre)
      tds = tr.css('td')
      curso[:disciplinas][semestre].push({:codigo      => tds[0].text.gsub(/\s+/, ""), 
                                          :nome        => tds[1].text[1..-1], 
                                          :obrigatoria => obrigatoria,
                                          :cred_aula   => tds[2].text.gsub(/\s+/, ""),
                                          :cred_trab   => tds[3].text.gsub(/\s+/, ""),
                                          :carga_hr    => tds[4].text.gsub(/\s+/, ""),
                                          :requisitos  => {}})
    when '#CCCCCC' # A linha é um header de mudança de semestre.
      _semestre = tr.text.gsub(/\s+/, "").split("º")[0]
    when nil # Se a linha não tiver cor e nem for a que indica o subtotal de créditos, será um requisito da última disciplina encontrada.
      if !['Subtotal:', ' '].include? tr.css('td')[0].text
          requisito_codigo = tr.css('td')[0].text.gsub(/\s+/, "").split("-")[0][5..-1]
          requisito_texto  = tr.css('td')[1].text.gsub(/\s+/, "")

          if requisito_texto.index("Conjunto") != nil
              requisito_tipo = "conjunto"
          elsif requisito_texto.index("fraco") != nil
              requisito_tipo = "fracos"
          else
              requisito_tipo = "fortes"
          end

          if !curso[:disciplinas][semestre][-1][:requisitos].key?(requisito_tipo)
              curso[:disciplinas][semestre][-1][:requisitos][requisito_tipo] = []
          end

          curso[:disciplinas][semestre][-1][:requisitos][requisito_tipo].push(requisito_codigo)
      end
    when '#658CCF' # É o header da mudança das obrigatórias para as optativas.
      obrigatoria ^= true
    end
end

File.open("output.json","w") do |f|
  f.write(curso.to_json)
end