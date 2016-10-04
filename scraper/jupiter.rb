require 'nokogiri'  
require 'open-uri'
require 'json'

# todas em https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D
# jupiterurl = "https://uspdigital.usp.br/jupiterweb/listarGradeCurricular?codcg=86&codcur=86200&codhab=204&tipo=N"
# page = Nokogiri::HTML(open(jupiterurl)) 
page = Nokogiri::HTML(open("Jupiterweb.html")) # source pelo link está mal formada...

trs = page.css('table table table:last-child table tr') # linhas da tabela que contem as disciplinas

semestre     = 1
obrigatoria  = true
disciplinas  = {}

trs.drop(1).each do |tr|
    case tr['bgcolor']
        when '#FFFFFF' # disciplina
            if !disciplinas.key?(semestre)
                disciplinas[semestre] = []
            end
            tds = tr.css('td')
            disciplinas[semestre].push({:codigo      => tds[0].text.gsub(/\s+/, ""), 
                                        :nome        => tds[1].text[1..-1], 
                                        :obrigatoria => obrigatoria,
                                        :cred_aula   => tds[2].text.gsub(/\s+/, ""),
                                        :cred_trab   => tds[3].text.gsub(/\s+/, ""),
                                        :carga_hr    => tds[4].text.gsub(/\s+/, ""),
                                        :requisitos  => []})

        when '#CCCCCC' # header de mudança de semestre
            semestre = tr.text.gsub(/\s+/, "").split("º")[0]

        when nil  # requisito
            if !['Subtotal:', ' '].include? tr.css('td')[0].text
                disciplinas[semestre][-1][:requisitos].push(tr.css('td')[0].text.gsub(/\s+/, "").split("-")[0][5..-1])
            end

        when '#658CCF' # header das optativas
            obrigatoria = false
    end
end

File.open("jupiter.json","w") do |f|
  f.write(disciplinas.to_json)
end