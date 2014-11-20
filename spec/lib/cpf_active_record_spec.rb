require 'spec_helper'

class Pessoa < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cpf :codigo
end

describe Pessoa do

  let(:pessoa) { Pessoa.new }
  let(:cpfs)   { [Faker::CPF.numeric, Faker::CPF.pretty] }

  it { expect(subject).to respond_to(:codigo) }

  context 'com cpf valido' do
    it 'deveria atribuir cpf ao criar objeto' do
      cpfs.each do |cpf|
        p = Pessoa.new(codigo: cpf)
        expect(p.codigo.numero).to eq cpf.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria atribuir cpf apos criar objeto' do
      cpfs.each do |cpf|
        pessoa.codigo = cpf
        expect(pessoa.codigo.numero).to eq cpf.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria alterar o valor do cpf informado' do
      cpfs.each do |cpf|
        pessoa.codigo = 'teste'
        pessoa.codigo = cpf
        expect(pessoa.codigo.numero).to eq cpf.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria ter cpf ser valido' do
      cpfs.each do |cpf|
        pessoa.codigo = cpf
        expect(pessoa.codigo.valido?).to be true
      end
    end

    it 'deveria transformar em string' do
      cpfs.each do |cpf|
        pessoa.codigo = cpf
        expect(pessoa.codigo.to_s).to eq cpf.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria exibir cpf formatado' do
      cpfs.each do |cpf|
        cpf.gsub!(/[^0-9]/, '')
        pessoa.codigo = cpf
        expect(pessoa.codigo.formatado).to eq "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
      end
    end

    it 'deveria ser um registro valido' do
      pessoa.codigo = cpfs.first
      expect(pessoa.valid?).to be true
    end

    it 'deveria persistir' do
      pessoa.codigo = cpfs.first
      expect { pessoa.save }.to change(Pessoa, :count).by 1
    end

    it 'deveria carregar pessoa com cpf salvo' do
      record = Pessoa.create!(codigo: (cpf = Faker::CPF.numeric))
      loaded = Pessoa.find(record.id)
      expect(record.codigo.numero).to eq loaded.codigo.numero
      expect(loaded.codigo.numero).to eq cpf
    end

    it 'deveria atualizar pessoa com novo cpf' do
      record = Pessoa.create!(codigo: Faker::CPF.numeric)
      record.update(codigo: (cpf = Faker::CPF.numeric))
      record.reload
      expect(record.codigo.numero).to eq cpf
    end

    it 'deveria comparar com string utilizando ==' do
      pessoa.codigo = (cpf = Faker::CPF.numeric)
      expect(pessoa.codigo).to eq cpf
    end

    it 'deveria comparar com objeto cpf utilizando ==' do
      cpf = Faker::CPF.numeric
      obj = ActAsCnpjCpf::Cpf.new(cpf)
      pessoa.codigo = cpf
      expect(pessoa.codigo).to eq obj
    end
  end
end
