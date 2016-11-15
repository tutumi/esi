require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :email => "caio@teixeira.com",
      :nusp => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do
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
