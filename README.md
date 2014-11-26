# act_as_cnpj_cpf

[![Build Status](https://travis-ci.org/josuelima/act_as_cnpj_cpf.svg?branch=master)](https://travis-ci.org/josuelima/act_as_cnpj_cpf)
[![Code Climate](https://codeclimate.com/github/josuelima/act_as_cnpj_cpf/badges/gpa.svg)](https://codeclimate.com/github/josuelima/act_as_cnpj_cpf)
[![Test Coverage](https://codeclimate.com/github/josuelima/act_as_cnpj_cpf/badges/coverage.svg)](https://codeclimate.com/github/josuelima/act_as_cnpj_cpf)

** Rubygem to format and validate CNPJ (Brazilian company registration number) and CPF (Brazilian citizens registration number). You can use it solo or as an ActiveRecord plugin. **

act_as_cnpj_cpf é uma Rubygem para validar e formatar CNPJ e CPF.

## Funcionalidades

* Valida CPF e CNPJ com ou sem formatação
* Integração com ActiveRecord
* Formata número para o padrão do CNPJ ou CPF (xx.xxx.xxx/xxxx-xx e xxx.xxx.xxx-xx)
* Possibilidade de utilizar um atributo como CNPJ ou CPF ao mesmo tempo
* Permite persistir cpf ou cnpj inválido (caso seja especificado com permite_invalido: true)

Este projeto foi inicialmente desenvolvido como uma extensão da gem [brcpfcnpj](https://github.com/tapajos/brazilian-rails/tree/master/brcpfcnpj) e em seguida totalmente re-escrito por se tratar de uma proposta diferente. Além das novas funcionalidades, diferentemente do brcpfcnpj, este projeto utiliza o número sem formatação como padrão para salvar no banco de dados e exibir (podendo ser exibido formatado com .formatado)

## Instalação

```bash
$ gem install act_as_cnpj_cpf
```

ou adicione act_as_cnpj_cpf ao seu Gemfile e `bundle install`:

```ruby
gem 'act_as_cnpj_cpf'
```

## Uso

### ActiveRecord

CPF Válido

```ruby
class Pessoa < ActiveRecord
  # cpf é um atributo no seu model Pessoa
  usar_como_cpf :cpf
end

fulano = Pessoa.new(cpf: '67392957864')
# ou
fulano = Pessoa.new(cpf: '673.929.578-64')

fulano.cpf # retorna numero sem formatação 67392957864
fulano.cpf.formatado # retorna 673.929.578-64
fulano.cpf.valido? # retorna true
fulano.valid? # retorna true
fulano.save # retorna true e salva objeto sem formatação
```

CPF Inválido

```ruby
fulano = Pessoa.new(cpf: '111111')
fulano.cpf # retorna 111111
fulano.cpf.valido? # retorna false
fulano.cpf.formatado # retorna 111111
fulano.valid? # retorna false e adiciona mensagem de erro ao model (fulano.errors)
```