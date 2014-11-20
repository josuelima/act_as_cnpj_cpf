module CnpjCpfActiveRecord
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def usar_como_cnpj(*args)
      init(args, 'Cnpj')
    end

    def usar_como_cpf(*args)
      init(args, 'Cpf')
    end

    # infere se eh cnpj ou cpf pelo tamanho
    # da string passada
    def usar_como_cnpj_ou_cpf(*args)
    end
  end
end