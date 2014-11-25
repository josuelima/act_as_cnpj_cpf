shared_examples 'objeto valido' do
  it 'instancia com numero sem formatacao' do
    codigos.each do |codigo|
      expect(model.new(codigo).numero).to eq codigo.gsub(/[^0-9]/, '')
    end
  end

  it '#formatado' do
    codigos.each do |codigo|
      formatado = if codigo.gsub(/[^0-9]/, '').length == 11
                    codigo =~ formato_cpf
                    "#{$1}.#{$2}.#{$3}-#{$4}"
                  else
                    codigo =~ formato_cnpj
                    "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"
                  end
      expect(model.new(codigo).formatado).to eq formatado
    end
  end

  it '#valido?' do
    codigos.each do |codigo|
      expect(model.new(codigo).valido?).to be true
    end
  end

  it '#to_s' do
    codigos.each do |codigo|
      expect(model.new(codigo).to_s).to eq codigo.gsub(/[^0-9]/, '')
    end
  end

  it '#==' do
    geradores.each do |gerador|
      codigo = gerador.numeric
      expect(model.new(codigo)).to eq model.new(codigo)
      expect(model.new(codigo)).to eq codigo
    end
  end
end

shared_examples 'objeto invalido' do
  it 'instancia com numero vazio' do
    invalidos.each do |codigo|
      expect(model.new(codigo).numero).to eq codigo
    end
  end

  it '#formatado' do
    invalidos.each do |codigo|
      expect(model.new(codigo).formatado).to eq ''
    end
  end

  it '#valido?' do
    invalidos.each do |codigo|
      expect(model.new(codigo).valido?).to eq false
    end
  end

  it '#to_s' do
    invalidos.each do |codigo|
      expect(model.new(codigo).to_s).to eq codigo
    end
  end
end
