module ActAsCnpjCpf
  class Cpf
    include Base

    def formatado
      @numero =~ /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/
      valido? ? "#{$1}.#{$2}.#{$3}-#{$4}" : ''
    end

    private
    
      LENGTH  = 11
      REGEX   = /^(\d{3}\.?\d{3}\.?\d{3})-?(\d{2})$/
      ALGS_1  = [10, 9, 8, 7, 6, 5, 4, 3, 2]
      ALGS_2  = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]
  end
end
