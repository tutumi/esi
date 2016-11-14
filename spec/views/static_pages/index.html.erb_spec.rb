require 'rails_helper'

RSpec.describe "static_pages/index.html.erb", type: :view do
   it "renders links" do
    render
    assert_select "a", :href => root_path
    assert_select "a", :href => about_path
    assert_select "a", :href => contact_path
    assert_select "a", :href => login_path, :count => 2
    assert_select "a", :href => signup_path
  end
end
