require 'nokogumbo'
require 'open-uri'

class UnitScraper
	@@units = []

  def self.scrap
    url = "https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D"

    page = Nokogiri.HTML5(open(url)) 

    self.parse_tds(page.css('table')[2].css('td'))

    self.parse_tds(page.css('table')[4].css('td'))

    return @@units

	end

	def self.parse_tds(tds)
		(2...tds.size).step(2).each do |index|
    	@@units.push(tds[index].text.strip)
    end
	end

end