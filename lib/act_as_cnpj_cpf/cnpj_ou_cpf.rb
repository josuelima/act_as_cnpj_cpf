module ActAsCnpjCpf
  class CnpjOuCpf
    extend Forwardable
    # forward dos metodos e vars para o objeto criado de acordo
    # com o numero passado
    def_delegators :@instance, :numero, :to_s, :valido?, :formatado, :==

    # Infere se utiliza cnpj ou cpf pelo tamanho
    # da string passada
    #
    # 11 = cpf | > 11 = cnpj
    #
    # Caso seja um numero invalido, o proprio objeto
    # se encarrega da validacao.
    def initialize(numero)
      klass     = numero.to_s.gsub(/[^0-9]/, '').length == 11 ? Cpf : Cnpj
      @instance = klass.new(numero)
    end

    def eh_cpf?
      @instance.is_a?(Cpf)
    end

    def eh_cnpj?
      @instance.is_a?(Cnpj)
    end
  end
end
