# -*- encoding : utf-8 -*-
module ActAsCnpjCpf
  module CnpjCpfActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      %w(cnpj cpf cnpj_ou_cpf).each do |method|
        define_method("usar_como_#{method}") do |field, options = {}| 
          init(field, options, "ActAsCnpjCpf::#{method.split('_').map(&:capitalize).join}")
        end
      end

      def init(field, options, klass)
        add_composed_class(field, klass)
        module_eval(create_validation(field.to_s, options, klass))
      end

      # Adiciona reader e writer 
      # http://api.rubyonrails.org/classes/ActiveRecord/Aggregations/ClassMethods.html
      def add_composed_class(name, klass)
        options = {class_name: klass, mapping: [name.to_s, 'numero'], allow_nil: true}
        cons    = Proc.new { |numero| eval(klass).new(numero) }
        composed_of name, options.merge({constructor: cons, converter: cons})
      end

      # cria validacao para o model
      def create_validation(field, options, klass)
        str = <<-CODE
          validate :#{field}_vazio?, :#{field}_valido?

          def #{field}_vazio?
            self.errors.add('#{field}', 'número vazio') if #{field}.nil? &&
                                                          !#{field}_permite_invalido?
          end

          def #{field}_valido?
            unless #{field}.nil?
              self.errors.add('#{field}', 'número inválido') unless #{field}.valido? ||
                                                                    #{field}_permite_invalido?
            end
          end

          def #{field}_permite_invalido?
            #{options[:permite_invalido] || false}
          end

          private :#{field}_permite_invalido?
        CODE
      end
    end
  end
end
