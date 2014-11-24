require 'spec_helper'

class Pessoa < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cpf :codigo
end

class PessoaInvalida < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cpf :codigo, permite_invalido: true
end

describe 'usar codigo como cpf' do
  let(:model)        { Pessoa }
  let(:model_inv)    { PessoaInvalida }
  let(:instance)     { Pessoa.new }
  let(:instance_inv) { PessoaInvalida.new }
  let(:tipo)         { ActAsCnpjCpf::Cpf }
  let(:formato_cpf)  { /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/ }
  let(:geradores)    { [ Faker::CPF ] }
  let(:codigos)      { [ Faker::CPF.numeric, Faker::CPF.pretty ] }
  let(:invalidos)    { [ '', 'asda', '11111111112', 11 ] }

  it_behaves_like 'entidade valida'
  it_behaves_like 'entidade invalida com permissao'
  it_behaves_like 'entidade validavel'
end
