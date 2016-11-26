require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :email => "name@usp.br",
        :nusp => "1111111",
        :password => "teste123",
        :course => Course.create()
      ),
      User.create!(
        :name => "Name",
        :email => "name@usp.br",
        :nusp => "1111111",
        :password => "teste123",
        :course => Course.create()
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "name@usp.br".to_s, :count => 2
    assert_select "tr>td", :text => "1111111".to_s, :count => 2
  end
end
