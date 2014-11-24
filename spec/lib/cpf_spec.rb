require 'spec_helper'

module ActAsCnpjCpf
  describe Cpf do
    let(:model)       { Cpf }
    let(:codigos)     { [ Faker::CPF.numeric, Faker::CPF.pretty ] }
    let(:invalidos)   { ['', ' ', 1, 'aaaaa c', '11111111111', '11' '111.111.111-11'] }
    let(:model)       { ActAsCnpjCpf::Cpf }
    let(:gerador)     { Faker::CPF }
    let(:formato_cpf) { /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/ }

    it_behaves_like 'objeto valido'
    it_behaves_like 'objeto invalido'
  end
end
