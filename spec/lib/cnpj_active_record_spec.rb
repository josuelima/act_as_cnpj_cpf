require 'spec_helper'

class Empresa < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj :codigo
end

class EmpresaInvalida < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cnpj :codigo, permite_invalido: true
end

describe Empresa do
  it { expect(subject).to respond_to(:codigo) }

  context 'com cnpj valido' do
    let(:empresa) { Empresa.new }
    let(:cnpjs)   { [Faker::CNPJ.numeric, Faker::CNPJ.pretty] }

    it 'deveria atribuir cnpj ao criar objeto' do
      cnpjs.each do |cnpj|
        e = Empresa.new(codigo: cnpj)
        expect(e.codigo.numero).to eq cnpj.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria atribuir cnpj apos criar objeto' do
      cnpjs.each do |cnpj|
        empresa.codigo = cnpj
        expect(empresa.codigo.numero).to eq cnpj.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria alterar o valor do cnpj informado' do
      cnpjs.each do |cnpj|
        empresa.codigo = 'teste'
        empresa.codigo = cnpj
        expect(empresa.codigo.numero).to eq cnpj.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria ter cnpj ser valido' do
      cnpjs.each do |cnpj|
        empresa.codigo = cnpj
        expect(empresa.codigo.valido?).to be true
      end
    end

    it 'deveria transformar em string' do
      cnpjs.each do |cnpj|
        empresa.codigo = cnpj
        expect(empresa.codigo.to_s).to eq cnpj.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria exibir cnpj formatado' do
      cnpjs.each do |cnpj|
        cnpj.gsub!(/[^0-9]/, '')
        empresa.codigo = cnpj
        expect(empresa.codigo.formatado).to eq "#{cnpj[0..1]}.#{cnpj[2..4]}.#{cnpj[5..7]}/#{cnpj[8..11]}-#{cnpj[12..13]}"
      end
    end

    it 'deveria ser um registro valido' do
      empresa.codigo = cnpjs.first
      expect(empresa.valid?).to be true
    end

    it 'deveria persistir' do
      empresa.codigo = cnpjs.first
      expect { empresa.save }.to change(Empresa, :count).by 1
    end

    it 'deveria carregar empresa com cnpj salvo' do
      record = Empresa.create!(codigo: (cnpj = Faker::CNPJ.numeric))
      loaded = Empresa.find(record.id)
      expect(record.codigo.numero).to eq loaded.codigo.numero
      expect(loaded.codigo.numero).to eq cnpj
    end

    it 'deveria atualizar empresa com novo cnpj' do
      record = Empresa.create!(codigo: Faker::CNPJ.numeric)
      record.update(codigo: (cnpj = Faker::CNPJ.numeric))
      record.reload
      expect(record.codigo.numero).to eq cnpj
    end

    it 'deveria comparar com string utilizando ==' do
      empresa.codigo = (cnpj = Faker::CNPJ.numeric)
      expect(empresa.codigo).to eq cnpj
    end

    it 'deveria comparar com objeto cnpj utilizando ==' do
      cnpj = Faker::CNPJ.numeric
      obj = ActAsCnpjCpf::Cnpj.new(cnpj)
      empresa.codigo = cnpj
      expect(empresa.codigo).to eq obj
    end
  end

  context 'com cnpj invalido' do
    let(:empresa) { Empresa.new }
    let(:cnpjs)   { ['', 'asda', '11111111112', 11] }

    it 'deveria atribuir cnpj em branco ao criar objeto' do
      cnpjs.each do |cnpj|
        e = Empresa.new(codigo: cnpj)
        expect(e.codigo.numero).to eq ''
      end
    end

    it 'deveria atribuir cnpj em branco apos criar objeto' do
      cnpjs.each do |cnpj|
        empresa.codigo = cnpj
        expect(empresa.codigo.numero).to eq ''
      end
    end

    it 'deveria ter cnpj ser invalido' do
      cnpjs.each do |cnpj|
        empresa.codigo = cnpj
        expect(empresa.codigo.valido?).to be false
      end
    end

    it 'deveria transformar em string em branco' do
      cnpjs.each do |cnpj|
        empresa.codigo = cnpj
        expect(empresa.codigo.to_s).to eq ''
      end
    end

    it 'deveria exibir cnpj formatado em branco' do
      cnpjs.each do |cnpj|
        empresa.codigo = cnpj
        expect(empresa.codigo.formatado).to eq ''
      end
    end

    it 'deveria ser um registro invalido' do
      empresa.codigo = cnpjs.first
      expect(empresa.valid?).to be false
    end

    it 'nao deveria persistir' do
      empresa.codigo = cnpjs.first
      expect { empresa.save }.to change(Empresa, :count).by 0
    end

    it 'nao persiste com cnpj nulo' do
      e = Empresa.new
      expect(empresa.save).to be false
    end

    context 'validations' do
      it 'deveria conter erro para codigo' do
        expect(empresa.valid?).to be false
        expect(empresa.errors[:codigo]).to_not be_empty
      end

      it 'deveria conter mensagem de erro para codigo vazio' do
        e = Empresa.new
        expect(e.valid?).to be false
        expect(e.errors[:codigo]).to eq [I18n.translate('errors.messages.blank')]
      end

      it 'deveria conter mensagem de erro para codigo invalido' do
        e = Empresa.new(codigo: '1234')
        expect(e.valid?).to be false
        expect(e.errors[:codigo]).to eq [I18n.translate('errors.messages.invalid')]
      end
    end
  end
end

describe EmpresaInvalida do
  let(:empresa) { EmpresaInvalida.new(codigo: '123123') }

  it { expect(subject).to respond_to(:codigo) }

  it 'deveria persistir' do
    expect { empresa.save }.to change(EmpresaInvalida, :count).by 1
  end

  it 'deveria salvar em branco' do
    empresa.save
    empresa.reload
    expect(empresa.codigo).to eq ''
  end

  it 'deveria persistir com cnpj nulo' do
    empresa.codigo = nil
    expect { empresa.save }.to change(EmpresaInvalida, :count).by 1
  end
end
