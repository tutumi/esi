require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :email => "caio@teixeira.com.br",
        :nusp => "Nusp"
      ),
      User.create!(
        :name => "Name",
        :email => "caio@teixeira.com.br",
        :nusp => "Nusp"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "caio@teixeira.com.br".to_s, :count => 2
    assert_select "tr>td", :text => "Nusp".to_s, :count => 2
  end
end
