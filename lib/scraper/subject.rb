require 'nokogumbo'
require 'open-uri'

class SubjectScraper
  def self.scrap(page)
    # Seletor que retorna as linhas da tabela com as disciplinas e seus requisitos.
    #trs = page.css('table table table:last-child table tr')
    trs = page.css('table[bgcolor="#FFFFFF"] table tr')

    disciplinas  = {}
    semestre = 1
    tipo = "obrigatoria"

    trs.each do |tr|
      case tr['bgcolor']
        when '#FFFFFF' # A linha representa uma disciplina.
          disciplinas[semestre] ||= []
          tds = tr.css('td')
          #TODO: fazer funcionar pra requisitos do tipo "ou"
          next if tds[0].text.strip == "  ou"
          disciplinas[semestre].push({:codigo        => tds[0].text.strip, 
                                      :nome          => tds[1].text[1..-1], 
                                      :tipo          => tipo,
                                      :credito_aula  => tds[2].text.strip.empty? ? 0 : tds[2].text.strip.to_i,
                                      :credito_trab  => tds[3].text.strip.empty? ? 0 : tds[3].text.strip.to_i,
                                      :carga_horaria => tds[4].text.strip.empty? ? 0 : tds[4].text.strip.to_i,
                                      :carga_estagio => tds[5].text.strip.empty? ? 0 : tds[5].text.strip.to_i,
                                      :carga_pratica => tds[6].text.strip.empty? ? 0 : tds[6].text.strip.to_i,
                                      :carga_aaca    => tds[7].text.strip.empty? ? 0 : tds[7].text.strip.to_i,
                                      :requisitos    => {"fraco" => [], "forte" => [], "conjunto" => []}})
        when '#CCCCCC' # A linha é um header de mudança de semestre.
          semestre = tr.text.gsub(/\s+/, "").split("º")[0]
        when nil # Se a linha não tiver cor e nem for a que indica o subtotal de créditos, será um requisito da última disciplina encontrada.
          if !['Subtotal:', ' '].include? tr.css('td')[0].text
              tds = tr.css('td')
              requisito_codigo = tds[0].text.gsub(/\s+/, "").split("-")[0][5..-1]
              disciplinas[semestre][-1][:requisitos][self.tipo_requisito(tds[1].text.strip)].push(requisito_codigo)
          end
        when '#658CCF' # É o header da mudança das obrigatórias para as optativas.
          tipo = self.tipo_disciplina(tr.text)
        end
    end

    return disciplinas
  end

  def self.tipo_requisito(texto)
    return "conjunto" if texto.index("Conjunto")
    return "fraco" if texto.index("fraco")
    return "forte"
  end

  def self.tipo_disciplina(texto)
    return "obrigatoria" if texto.index("Obrigatórias")
    return "eletiva" if texto.index("Eletivas")
    return "livre"
  end
end
