require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "Ana Carolina Trino de Carvalho",
      :email => "ana.trino.carvalho@usp.br",
      :nusp => "8641897",
      :password => "teste123"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_nusp[name=?]", "user[nusp]"
    end
  end
end
