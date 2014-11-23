module ActAsCnpjCpf
  class Cnpj
    include Base
    
    LENGTH = 14
    REGEX  = /^(\d{2}\.?\d{3}\.?\d{3}\/?\d{4})-?(\d{2})$/
    ALGS_1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    ALGS_2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

    def formatado
      @numero =~ /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/
      valido? ? "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}" : ''
    end
  end
end
