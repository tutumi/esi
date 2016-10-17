require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Caio Teixeira", email: "caio@teixeira.com", nusp: "8516883")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end
  
  test "nusp should be smaller" do
    @user.nusp = "123456479569954956"
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 300 + "@usp.br"
    assert_not @user.valid?
  end
end