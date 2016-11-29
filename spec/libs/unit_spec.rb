require 'rails_helper'
require "#{::Rails.root}/lib/scraper/unit.rb"

RSpec.describe UnitScraper do
  before :each do
    response_file = File.new("#{::Rails.root}/spec/webmocks/pagina_unidades.txt")
    stub_request(:get, "https://uspdigital.usp.br/jupiterweb/jupColegiadoLista?tipo=D").to_return(response_file.read)
  end

  describe "#get_page" do
    it "returns a Nokogiri HTML document" do
      expect(subject.get_page.class).to eq(Nokogiri::HTML::Document)
    end
  end

  describe "#tds_units" do
    it "should return 120 <td>" do
      expect(subject.tds_units.length).to eq(120)
    end
  end

  describe "#tds_others" do
    it "should return 18 <td>" do
      expect(subject.tds_others.length).to eq(18)
    end
  end

  describe "#scrap" do
    it "should return 68 units" do
      expect(subject.scrap.length).to eq(68)
    end

    it "should start with EACH" do
      expect(subject.scrap[0]).to eq("86")
    end

    it "should end with Museu Paulista" do
      expect(subject.scrap[-1]).to eq("33")
    end
  end
end