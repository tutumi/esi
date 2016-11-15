require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #index" do
    it "returns http success for index page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
   describe "GET #about" do
    it "returns http success for about page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
   describe "GET #contact" do
    it "returns http success for about contact" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
