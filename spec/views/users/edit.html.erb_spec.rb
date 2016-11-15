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
      assert_select "select#user_courses_id[name=?]", "user[courses_id]"
      assert_select "input#user_startYear[name=?]", "user[startYear]"
      assert_select "input#user_password[name=?]", "user[password]"
      assert_select "input#user_password_confirmation[name=?]", "user[password_confirmation]"
    end
    
    assert_select "input[type=submit]"
  end
end
