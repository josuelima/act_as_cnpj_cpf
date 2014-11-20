module ActAsCnpjCpf
  class CnpjOuCpf

    def initialize(numero)
      klass = numero.to_s.gsub(/[^0-9]/, '').length == 11 ? Cpf : Cnpj
      self  = klass.new(numero)
    end

  end
end
