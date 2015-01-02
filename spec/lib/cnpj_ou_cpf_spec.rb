require 'spec_helper'

module ActAsCnpjCpf
  describe CnpjOuCpf do
    let(:codigos)      { [ Faker::CNPJ.numeric, Faker::CNPJ.pretty,
                           Faker::CPF.numeric,  Faker::CPF.pretty ] }
    let(:invalidos)    { ['', ' ', 1, 'aaaaa c', '11111111111', '11' '11.111.111/0000-11'] }
    let(:model)        { ActAsCnpjCpf::CnpjOuCpf }
    let(:geradores)    { [ Faker::CNPJ, Faker::CPF ] }
    let(:formato_cnpj) { /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/ }
    let(:formato_cpf)  { /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/ }

    it_behaves_like 'objeto valido'
    it_behaves_like 'objeto invalido'

    context '#eh_cpf? e #eh_cnpj?' do
      it 'deveria identificar como cpf' do
        cpf = model.new(codigo: Faker::CPF.numeric)
        expect(cpf.eh_cpf?).to  be true
        expect(cpf.eh_cnpj?).to be false
      end
    end
  end
end
