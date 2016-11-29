module UsersHelper
    
    
    def buttonLabel 
        if @parentPage == "edit"
            "Atualizar Conta"
        else
            "Criar Usuário"
        end
    end
    
    def parentFormPage(val)
        @parentPage = val
    end
    
end
