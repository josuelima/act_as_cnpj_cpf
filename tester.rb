$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'forwardable'
require 'lib/act_as_cnpj_cpf'
require 'cpf_faker'

ActiveRecord::Base.establish_connection adapter:  'sqlite3', 
                                        database: 'cnpj_cpf_spec.sqlite3'

class Empresa < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj_ou_cpf :codigo
end

class Empresa2 < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj_ou_cpf :codigo
end

c1 = Faker::CPF.numeric

e  = Empresa.new(codigo: c1)
e2 = Empresa.new(codigo: c1)

puts e.codigo == e2.codigo
