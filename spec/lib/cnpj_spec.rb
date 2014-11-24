require 'spec_helper'

module ActAsCnpjCpf
  describe Cnpj do
    let(:model)        { Cnpj }
    let(:codigos)      { [ Faker::CNPJ.numeric, Faker::CNPJ.pretty ] }
    let(:invalidos)    { ['', ' ', 1, 'aaaaa c', '11111111111111', '11' '11.111.111/0000-11'] }
    let(:model)        { ActAsCnpjCpf::Cnpj }
    let(:gerador)      { Faker::CNPJ }
    let(:formato_cnpj) { /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/ }

    it_behaves_like 'objeto valido'
    it_behaves_like 'objeto invalido'
  end
end
