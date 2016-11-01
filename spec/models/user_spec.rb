require 'rails_helper'
require 'spec_helper'
 
RSpec.describe User, type: :model do
    #pending "add some examples to (or delete) #{__FILE__}"
    it "should destroy the user" do
      #@user = User.create(name: "Michel Inacio Roussef", email: "email@liame.com", nusp: "8516666")
      #@user.destroy(name: "Michel Inacio Roussef", email: "email@liame.com", nusp: "8516666")
      #@user.destroy
      #@user.delete
      #expect(@user).not_to be_valid
    end
end

#describe "adding or delleting test" do
 
#end

describe "validation tests" do
    before :all do
      @user = User.new(name: "Caio Teixeira", email: "caio@teixeira.com", nusp: "8516883")
    end
    it "should be valid" do
      expect(@user).to be_valid
    end
    
    it "name should be present" do
      @user.name = "    "
      expect(@user).not_to be_valid
    end
    it "nusp should be present" do
      @user.nusp = ""
      expect(@user).not_to be_valid
    end
    it "nusp should be smaller" do
      @user.nusp = "123456479569954956"
      expect(@user).not_to be_valid
    end
    it "name should not be too long" do
      @user.name = "a" * 51
      expect(@user).not_to be_valid
    end
    it "email should not be too long" do
      @user.email = "a" * 300 + "@usp.br"
      expect(@user).not_to be_valid
    end
    
    #it "email validation should accept valid addresses"
      #valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
       #                  first.last@foo.jp alice+bob@baz.cn]
      #valid_addresses.each do |valid_address|
      #@user.email = valid_address
      #expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    #end
    
     #it "email validation should reject invalid addresses"
     #invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
      #                     foo@bar_baz.com foo@bar+baz.com]
      #invalid_addresses.each do |invalid_address|
      #@user.email = invalid_address
      #assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    #end
end