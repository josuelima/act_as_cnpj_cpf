require './base'
require './cnpj'

a = ActAsCnpjCpf::Cnpj.new '09.135.930/0001-27'
puts a.valido?
puts a.formatado