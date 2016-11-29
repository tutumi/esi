require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
    
  let(:course) {
    Course.create({'nome' => 'Bacharelado em Educação Física e Saúde', 'codcg' => 9999, 'codcur' => 999999, 'codhab' => 999, 'duracao_min' => 8, 'duracao_ideal' => 8, 'duracao_max' => 12, 'ch_obrigatoria_aula' => 1830, 'ch_obrigatoria_trab' => 720, 'ch_eletiva_aula' => 240, 'ch_eletiva_trab' => 0, 'ch_livre_aula' => 750, 'ch_livre_trab' => 0, 'ch_estagio' => 480, 'periodo' => 'vespertino'})
  }
  
  let(:new_user) {
    User.create({'name' => 'Bruno Murozaki', 'email' => 'brunomurozaki@email.com.br', 'nusp' => '0000004', 'password' => 'password', 'course_id' => course.id})
  }
    
  describe "logged_in user" do
      it "returns false" do
        expect(helper.logged_in?).to eq(false)
      end
      
      it "returns true" do
        user = new_user
        helper.log_in(user)
        expect(helper.logged_in?).to eq(true)
      end
  end
  
  describe "current_user" do
    it "should be the logged user" do
        user = new_user
        helper.log_in(user)
        expect(helper.current_user).to eq(user)
    end
    
    it "should be nil" do
        user = new_user
        helper.log_in(user)
        helper.log_out
        expect(helper.current_user).to eq(nil)
    end
  end
  #pending "add some examples to (or delete) #{__FILE__}"
end
