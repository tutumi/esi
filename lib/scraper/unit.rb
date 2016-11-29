require 'nokogumbo'
require 'open-uri'

module UnitScraper
  @@page = nil
  
  def self.get_page
    return @@page if @@page
    @@page = Nokogiri.HTML5(open("https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D")) 
  end

  def self.scrap
    self.parse_tds(tds_units + tds_others)
  end

  def self.tds_units
    self.get_page.css('table')[2].css('td')
  end

  def self.tds_others
    self.get_page.css('table')[4].css('td')
  end

  def self.parse_tds(tds)
    units = []
    (2...tds.size).step(2).each do |index|
      units.push(tds[index].text.strip)
    end
    units
  end
end