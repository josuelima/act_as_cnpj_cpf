require './base'
require './cpf'

a = ActAsCnpjCpf::Cpf.new '06454383407'
puts a.valido?
puts a.numero