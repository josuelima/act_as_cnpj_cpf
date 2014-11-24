require 'spec_helper'

class Empresa < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj :codigo
end

class EmpresaInvalida < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj :codigo, permite_invalido: true
end

describe 'usar codigo como cnpj' do
  let(:model)        { Empresa }
  let(:model_inv)    { EmpresaInvalida }
  let(:instance)     { Empresa.new }
  let(:instance_inv) { EmpresaInvalida.new }
  let(:tipo)         { ActAsCnpjCpf::Cnpj }
  let(:formato)      { /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/ }
  let(:gerador)      { Faker::CNPJ }
  let(:codigos)      { [ Faker::CNPJ.numeric, Faker::CNPJ.pretty ] }
  let(:invalidos)    { [ '', 'asda', '11111111112123', 11 ] }

  it_behaves_like 'entidade valida'
  it_behaves_like 'entidade invalida com permissao'
  it_behaves_like 'entidade validavel'
end
