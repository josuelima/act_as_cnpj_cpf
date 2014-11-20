require 'spec_helper'

module ActAsCnpjCpf
  describe Cpf do
    context 'com cpf valido:' do
      let(:cpfs) { [Faker::CPF.numeric, Faker::CPF.pretty] }

      it 'instancia com numero cru' do
        cpfs.each do |c|
          expect(Cpf.new(c).numero).to eq c.gsub(/[^0-9]/, '')
        end
      end

      it 'formata' do
        cpfs.each do |c|
          cru = c.gsub(/[^0-9]/, '')
          expect(Cpf.new(c).formatado).
            to eq "#{cru[0..2]}.#{cru[3..5]}.#{cru[6..8]}-#{cru[9..10]}"
        end
      end

      it 'eh valido' do
        cpfs.each do |c|
          expect(Cpf.new(c).valido?).to be true
        end
      end

      it '#to_s' do
        cpfs.each do |c|
          expect(Cpf.new(c).to_s).to eq c.gsub(/[^0-9]/, '')
        end
      end

      it '==' do
        num   = Faker::CPF.numeric
        cpf_1 = Cpf.new(num)
        cpf_2 = Cpf.new(num)
        expect(cpf_1).to eq cpf_2
        expect(cpf_1).to eq num
      end
    end

    context 'com cnpj invalido:' do
      let(:cpfs) { ['', ' ', 1, 'aaaaa c', '11111111111', '11' '111.111.111-11'] }

      it 'instancia com numero vazio' do
        cpfs.each do |c|
          expect(Cpf.new(c).numero).to eq ''
        end
      end

      it 'nao formata' do
        cpfs.each do |c|
          expect(Cpf.new(c).formatado).to eq ''
        end
      end

      it 'nao eh valido' do
        cpfs.each do |c|
          expect(Cpf.new(c).valido?).to eq false
        end
      end

      it '#to_s' do
        cpfs.each do |c|
          expect(Cpf.new(c).to_s).to eq ''
        end
      end
    end
  end
end
