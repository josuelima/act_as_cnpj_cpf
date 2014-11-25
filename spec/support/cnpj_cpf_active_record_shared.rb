shared_examples 'entidade valida' do
  context 'com codigo valido' do
    it 'deveria atribuir o codigo ao criar objeto' do
      codigos.each do |codigo|
        reg = model.new(codigo: codigo)
        expect(reg.codigo.numero).to eq codigo.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria atribuir codigo apos criar objeto' do
      codigos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.numero).to eq codigo.gsub(/[^0-9]/, '')
      end
    end

    it '.numero' do
      codigos.each do |codigo|
        instance.codigo = 'teste'
        instance.codigo = codigo
        expect(instance.codigo.numero).to eq codigo.gsub(/[^0-9]/, '')
      end
    end

    it '#valido?' do
      codigos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.valido?).to be true
      end
    end

    it '#to_s' do
      codigos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.to_s).to eq codigo.gsub(/[^0-9]/, '')
      end
    end

    it '#formatado' do
      codigos.each do |codigo|
        codigo.gsub!(/[^0-9]/, '')
        instance.codigo = codigo      

        formatado = if instance.codigo.numero.length == 11
                      instance.codigo.numero =~ formato_cpf
                      "#{$1}.#{$2}.#{$3}-#{$4}"
                    else
                      instance.codigo.numero =~ formato_cnpj
                      "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"
                    end

        expect(instance.codigo.formatado).to eq formatado
      end
    end

    it '#valid?' do
      instance.codigo = codigos.first
      expect(instance.valid?).to be true
    end

    it '#save' do
      instance.codigo = codigos.first
      expect { instance.save }.to change(model, :count).by 1
    end

    it '#find' do
      geradores.each do |gerador|
        record = model.create!(codigo: (codigo = gerador.numeric))
        loaded = model.find(record.id)
        expect(record.codigo.numero).to eq loaded.codigo.numero
        expect(loaded.codigo.numero).to eq codigo
      end
    end

    it '#update' do
      geradores.each do |gerador|
        record = model.create!(codigo: gerador.numeric)
        record.update(codigo: (codigo = gerador.numeric))
        record.reload
        expect(record.codigo.numero).to eq codigo
      end
    end

    it '#== to_s' do
      geradores.each do |gerador|
        instance.codigo = (codigo = gerador.numeric)
        expect(instance.codigo).to eq codigo
      end
    end

    it '#== instance' do
      geradores.each do |gerador|
        codigo = gerador.numeric
        instance.codigo = codigo
        objeto = instance.codigo.class.new(codigo)
        expect(instance.codigo).to eq objeto
      end
    end
  end

  context 'com codigo invalido' do
    it 'deveria atribuir codigo em branco ao criar objeto' do
      invalidos.each do |codigo|
        obj = model.new(codigo: codigo)
        expect(obj.codigo.numero).to eq codigo
      end
    end

    it '.numero' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.numero).to eq codigo
      end
    end

    it '#valido' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.valido?).to be false
      end
    end

    it '#to_s' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.to_s).to eq codigo
      end
    end

    it '#formatado' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.formatado).to eq ''
      end
    end

    it '#valid?' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.valid?).to be false
      end
    end

    it '#save invalid' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect { instance.save }.to change(model, :count).by 0
      end
    end

    it '#save empty' do
      objeto = model.new
      expect(objeto.save).to be false
    end
  end
end

shared_examples 'entidade invalida com permissao' do
  it '#save' do
    expect { instance_inv.save }.to change(model_inv, :count).by 1
  end

  it '#save nil' do
    instance_inv.codigo = nil
    expect { instance_inv.save }.to change(model_inv, :count).by 1
  end

  it '#save #reload' do
    instance_inv.save
    instance_inv.reload
    expect(instance_inv.codigo).to eq nil
  end
end

shared_examples 'entidade validavel' do
  it '#errors' do
    expect(instance.valid?).to be false
    expect(instance.errors[:codigo]).to_not be_empty
  end

  it '#errors blank' do    
    expect(instance.valid?).to be false
    expect(instance.errors[:codigo]).to eq [I18n.translate('errors.messages.blank')]
  end

  it '#errors invalid' do
    instance.codigo = '12345678911'
    expect(instance.valid?).to be false
    expect(instance.errors[:codigo]).to eq [I18n.translate('errors.messages.invalid')]
  end
end
