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

    it 'deveria alterar o valor do codigo informado' do
      codigos.each do |codigo|
        instance.codigo = 'teste'
        instance.codigo = codigo
        expect(instance.codigo.numero).to eq codigo.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria ter codigo valido' do
      codigos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.valido?).to be true
      end
    end

    it 'deveria transformar em string' do
      codigos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.to_s).to eq codigo.gsub(/[^0-9]/, '')
      end
    end

    it 'deveria exibir codigo formatado' do
      codigos.each do |codigo|
        codigo.gsub!(/[^0-9]/, '')
        instance.codigo = codigo      

        if instance.codigo.is_a?(ActAsCnpjCpf::Cpf)
          instance.codigo.numero =~ formato_cpf
          formatado = "#{$1}.#{$2}.#{$3}-#{$4}"
        else
          instance.codigo.numero =~ formato_cnpj
          formatado = "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"
        end

        expect(instance.codigo.formatado).to eq formatado
      end
    end

    it 'deveria ser um registro valido' do
      instance.codigo = codigos.first
      expect(instance.valid?).to be true
    end

    it 'deveria persistir' do
      instance.codigo = codigos.first
      expect { instance.save }.to change(model, :count).by 1
    end

    it 'deveria carregar model com codigo salvo' do
      geradores.each do |gerador|
        record = model.create!(codigo: (codigo = gerador.numeric))
        loaded = model.find(record.id)
        expect(record.codigo.numero).to eq loaded.codigo.numero
        expect(loaded.codigo.numero).to eq codigo
      end
    end

    it 'deveria atualizar model com novo codigo' do
      geradores.each do |gerador|
        record = model.create!(codigo: gerador.numeric)
        record.update(codigo: (codigo = gerador.numeric))
        record.reload
        expect(record.codigo.numero).to eq codigo
      end
    end

    it 'deveria comparar com string utilizando ==' do
      geradores.each do |gerador|
        instance.codigo = (codigo = gerador.numeric)
        expect(instance.codigo).to eq codigo
      end
    end

    it 'deveria comparar instancia utilizando ==' do
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
        expect(obj.codigo.numero).to eq ''
      end
    end

    it 'deveria atribuir codigo em branco apos criar objeto' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.numero).to eq ''
      end
    end

    it 'deveria ser codigo invalido' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.valido?).to be false
      end
    end

    it 'deveria transformar em string em branco' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.to_s).to eq ''
      end
    end

    it 'deveria exibir codigo formatado em branco' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.codigo.formatado).to eq ''
      end
    end

    it 'deveria ser registro invalido' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect(instance.valid?).to be false
      end
    end

    it 'nao deveria persistir com codigo invalido' do
      invalidos.each do |codigo|
        instance.codigo = codigo
        expect { instance.save }.to change(model, :count).by 0
      end
    end

    it 'nao persiste com codigo nulo' do
      objeto = model.new
      expect(objeto.save).to be false
    end
  end
end

shared_examples 'entidade invalida com permissao' do
  it 'deveria persistir' do
    expect { instance_inv.save }.to change(model_inv, :count).by 1
  end

  it 'deveria persistir com codigo nulo' do
    instance_inv.codigo = nil
    expect { instance_inv.save }.to change(model_inv, :count).by 1
  end

  it 'deveria persistir e carregar com codigo nulo' do
    instance_inv.save
    instance_inv.reload
    expect(instance_inv.codigo).to eq nil
  end
end

shared_examples 'entidade validavel' do
  it 'deveria conter erro para codigo' do
    expect(instance.valid?).to be false
    expect(instance.errors[:codigo]).to_not be_empty
  end

  it 'deveria conter mensagem de erro para codigo vazio' do    
    expect(instance.valid?).to be false
    expect(instance.errors[:codigo]).to eq [I18n.translate('errors.messages.blank')]
  end

  it 'deveria conter mensagem de erro para codigo invalido' do
    instance.codigo = '12345678911'
    expect(instance.valid?).to be false
    expect(instance.errors[:codigo]).to eq [I18n.translate('errors.messages.invalid')]
  end
end
