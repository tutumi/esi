require 'nokogumbo'
require 'open-uri'

class SubjectScraper

  def self.scrap(page)
    @@tipo = "obrigatoria"
    @@disciplinas  = {}
    @@semestre = 1
    # Seletor que retorna as linhas da tabela com as disciplinas e seus requisitos.
    #trs = page.css('table table table:last-child table tr')
    trs = page.css('table[bgcolor="#FFFFFF"] table tr')
    trs.each do |tr|
      case tr['bgcolor']
        # A linha representa uma disciplina.
        when '#FFFFFF'
          self.nova_disciplina(tr)
        # A linha é um header de mudança de semestre.
        when '#CCCCCC'
          self.atualiza_semestre(tr)
        # Se a linha não tiver cor e nem for a que indica o subtotal de créditos, será um requisito da última disciplina encontrada.
        when nil
          self.adiciona_requisito(tr)
        # É o header da mudança das obrigatórias para as optativas.
        when '#658CCF'
          self.atualiza_tipo(tr)
      end
    end
    return @@disciplinas
  end

  def self.nova_disciplina(tr)
    tds = tr.css('td')
    if tds[0].text.strip != "  ou" # Não diferencia requisitos do tipo "ou"
      @@disciplinas[@@semestre].push({:codigo        => tds[0].text.strip, 
                                      :nome          => tds[1].text[1..-1], 
                                      :tipo          => @@tipo,
                                      :credito_aula  => tds[2].text.strip.to_i,
                                      :credito_trab  => tds[3].text.strip.to_i,
                                      :carga_horaria => tds[4].text.strip.to_i,
                                      :carga_estagio => tds[5].text.strip.to_i,
                                      :carga_pratica => tds[6].text.strip.to_i,
                                      :carga_aaca    => tds[7].text.strip.to_i,
                                      :requisitos    => {"fraco" => [], "forte" => [], "conjunto" => []}})
    end
  end

  def self.atualiza_semestre(tr)
    @@semestre = tr.text.gsub(/\s+/, "").split("º")[0]
    @@disciplinas[@@semestre] ||= []
  end

  def self.adiciona_requisito(tr)
    if !['Subtotal:', ' '].include? tr.css('td')[0].text # Ignora as últimas linhas da tabela
      tds = tr.css('td')
      requisito_codigo = tds[0].text.gsub(/\s+/, "").split("-")[0][5..-1]
      @@disciplinas[@@semestre][-1][:requisitos][self.tipo_requisito(tds[1].text.strip)].push(requisito_codigo)
    end
  end

  def self.atualiza_tipo(tr)
    @@tipo = self.tipo_disciplina(tr.text)
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
