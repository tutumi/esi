require "rails_helper"

RSpec.describe StaticPagesController, type: :routing do
  describe "routing" do
    it "routes to root" do
      expect(:get => "/").to route_to("static_pages#index")
    end
    
    it "routes to about" do
      expect(:get => "/about").to route_to("static_pages#about")
    end
    
    it "routes to contact" do
      expect(:get => "/contact").to route_to("static_pages#contact")
    end
  end
end