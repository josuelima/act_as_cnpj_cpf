require 'spec_helper'

module ActAsCnpjCpf
  describe Cnpj do
    context 'com cnpj valido:' do
      let(:cnpjs) { [Faker::CNPJ.numeric, Faker::CNPJ.pretty] }

      it 'instancia com numero cru' do
        cnpjs.each do |c|
          expect(Cnpj.new(c).numero).to eq c.gsub(/[^0-9]/, '')
        end
      end

      it 'formata' do
        cnpjs.each do |c|
          cru = c.gsub(/[^0-9]/, '')
          expect(Cnpj.new(c).formatado).
            to eq "#{cru[0..1]}.#{cru[2..4]}.#{cru[5..7]}/#{cru[8..11]}-#{cru[12..13]}"
        end
      end

      it 'eh valido' do
        cnpjs.each do |c|
          expect(Cnpj.new(c).valido?).to be true
        end
      end

      it '#to_s' do
        cnpjs.each do |c|
          expect(Cnpj.new(c).to_s).to eq c.gsub(/[^0-9]/, '')
        end
      end

      it '==' do
        num    = Faker::CNPJ.numeric
        cnpj_1 = Cnpj.new(num)
        cnpj_2 = Cnpj.new(num)
        expect(cnpj_1).to eq cnpj_2
        expect(cnpj_1).to eq num
      end
    end

    context 'com cnpj invalido:' do
      let(:cnpjs) { ['', ' ', 1, 'aaaaa c', '11111111111111', '11' '11.111.111/1111-11'] }

      it 'instancia com numero vazio' do
        cnpjs.each do |c|
          expect(Cnpj.new(c).numero).to eq ''
        end
      end

      it 'nao formata' do
        cnpjs.each do |c|
          expect(Cnpj.new(c).formatado).to eq ''
        end
      end

      it 'nao eh valido' do
        cnpjs.each do |c|
          expect(Cnpj.new(c).valido?).to eq false
        end
      end

      it '#to_s' do
        cnpjs.each do |c|
          expect(Cnpj.new(c).to_s).to eq ''
        end
      end
    end
  end
end
