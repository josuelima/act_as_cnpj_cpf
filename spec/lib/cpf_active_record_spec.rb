require 'spec_helper'

class Pessoa < ActiveRecord::Base
  self.table_name = 'cnpj_cpf_test'
  usar_como_cpf :codigo
end

describe Pessoa do

  let(:pessoa) { Pessoa.new }
  let(:cpfs)   { [Faker::CPF.numeric, Faker::CPF.pretty] }

  it { expect(subject).to respond_to(:codigo) }

  context 'cpf valido:' do
    it 'atribui cpf valido ao model' do
      cpfs.each do |cpf|
        pessoa.codigo = cpf
        expect(pessoa.codigo.numero).to eq cpf.gsub(/[^0-9]/, '')
      end
    end

    it '#valido?' do
      cpfs.each do |cpf|
        pessoa.codigo = cpf
        expect(pessoa.codigo.valido?).to be true
      end
    end

    it '#to_s' do
      cpfs.each do |cpf|
        pessoa.codigo = cpf
        expect(pessoa.codigo.to_s).to eq cpf.gsub(/[^0-9]/, '')
      end
    end

    it '#formatado' do
      cpfs.each do |cpf|
        cpf.gsub!(/[^0-9]/, '')
        pessoa.codigo = cpf
        expect(pessoa.codigo.formatado).to eq "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..10]}"
      end
    end
  end
end
