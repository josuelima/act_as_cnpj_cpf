require 'spec_helper'

class Cliente < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj_ou_cpf :codigo
end

class ClienteInvalido < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj_ou_cpf :codigo, permite_invalido: true
end

describe 'usar codigo como cnpj ou cpf' do
  let(:model)        { Cliente }
  let(:model_inv)    { ClienteInvalido }
  let(:instance)     { Cliente.new }
  let(:instance_inv) { ClienteInvalido.new }
  let(:tipo)         { ActAsCnpjCpf::CnpjOuCnpj }
  let(:formato_cnpj) { /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/ }
  let(:formato_cpf)  { /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/ }
  let(:geradores)    { [ Faker::CPF, Faker::CNPJ ] }
  let(:codigos)      { [ Faker::CNPJ.numeric, Faker::CNPJ.pretty, 
                         Faker::CPF.numeric, Faker::CPF.pretty ] }
  let(:invalidos)    { [ '', 'asda', '11111111112123', 11 ] }

  it_behaves_like 'entidade valida'
  it_behaves_like 'entidade invalida com permissao'
  it_behaves_like 'entidade validavel'
end
