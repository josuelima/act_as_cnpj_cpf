module ActAsCnpjCpf
  module Base
    attr_reader :numero

    def initialize(numero)
      @numero = numero.to_s.gsub(/[^0-9]/, '')
      @match  = @numero =~ self.class::REGEX
      @puro   = $1
      @digito = $2
      @numero = valido? ? $1+$2 : numero
    end

    def to_s
      @numero
    end

    def valido?
      return false unless @match
      verifica_numero
    end

    def == other
      other.respond_to?(:numero) ? self.numero == other.numero : self.numero == other
    end

    private

      def verifica_numero
        return false if @numero.length != self.class::LENGTH ||
                        @numero.scan(/\d/).uniq.length == 1

        primeiro_dv + segundo_dv(primeiro_dv) == @digito
      end

      def multiplica_e_soma(algs, numeros)
        results = []
        numeros.scan(/\d{1}/).each_with_index { |e, i| results[i] = e.to_i * algs[i] }
        results.inject { |s,e| s + e }
      end

      def dv(resto)
        resto < 2 ? 0 : 11 - resto
      end

      def primeiro_dv
        @primeiro ||= dv(multiplica_e_soma(self.class::ALGS_1, @puro) % 11).to_s
      end

      def segundo_dv(primeiro_verificador)
        dv(multiplica_e_soma(self.class::ALGS_2, @puro + primeiro_verificador) % 11).to_s
      end
  end
end
