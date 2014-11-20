require 'spec_helper'

module ActAsCnpjCpf
  describe CnpjOuCpf do
    context 'com cnpj ou cpf valido:' do
      let(:codigos) { [Faker::CNPJ.numeric, Faker::CNPJ.pretty,
                       Faker::CPF.numeric,  Faker::CPF.pretty] }

      it 'instancia com numero cru' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).numero).to eq c.gsub(/[^0-9]/, '')
        end
      end

      it 'formata' do
        codigos.each do |c|
          cru = c.gsub(/[^0-9]/, '')
          expect(CnpjOuCpf.new(c).formatado).
            to eq("#{cru[0..1]}.#{cru[2..4]}.#{cru[5..7]}/#{cru[8..11]}-#{cru[12..13]}").
            or eq("#{cru[0..2]}.#{cru[3..5]}.#{cru[6..8]}-#{cru[9..10]}")
        end
      end

      it 'eh valido' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).valido?).to be true
        end
      end

      it '#to_s' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).to_s).to eq c.gsub(/[^0-9]/, '')
        end
      end

      it '==' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).to_s).to eq c.gsub(/[^0-9]/, '')
        end
      end
    end

    context 'com cnpj ou cpf invalido:' do
      let(:codigos) { ['', ' ', 1, 'aaaaa c', '11111111111', '11' '11.111.111/1111-11'] }

      it 'instancia com numero vazio' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).numero).to eq ''
        end
      end

      it 'nao formata' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).formatado).to eq ''
        end
      end

      it 'nao eh valido' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).valido?).to eq false
        end
      end

      it '#to_s' do
        codigos.each do |c|
          expect(CnpjOuCpf.new(c).to_s).to eq ''
        end
      end
    end
  end
end
