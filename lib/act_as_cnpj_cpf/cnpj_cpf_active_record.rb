module ActAsCnpjCpf
  module CnpjCpfActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def usar_como_cnpj(*args)
        init(args, 'Cnpj')
      end

      def usar_como_cpf(*args)
        init(args, 'ActAsCnpjCpf::Cpf')
      end

      def usar_como_cnpj_ou_cpf(*args)
        init(args, 'CnpjOuCpf')
      end

      def init(args, klass)
        args.each do |name|
          add_composed_class(name, klass)
        end unless args.empty?
      end

      # Adiciona reader e writer 
      # http://api.rubyonrails.org/classes/ActiveRecord/Aggregations/ClassMethods.html
      def add_composed_class(name, klass)
        options = {class_name: klass, mapping: [name.to_s, 'numero'], allow_nil: true}

        constructor = Proc.new { |numero| eval(klass).new(numero) }
        converter   = Proc.new { |value|  eval(klass).new(value)  }

        composed_of name, options.merge({constructor: constructor, converter: converter})
      end
    end
  end
end
