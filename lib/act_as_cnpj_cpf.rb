$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'active_record'
require 'active_support/inflector'
require 'act_as_cnpj_cpf/version'
require 'act_as_cnpj_cpf/base'
require 'act_as_cnpj_cpf/cnpj'
require 'act_as_cnpj_cpf/cpf'
require 'act_as_cnpj_cpf/cnpj_ou_cpf'
require 'act_as_cnpj_cpf/cnpj_cpf_active_record'

ActiveRecord::Base.send :include, ActAsCnpjCpf::CnpjCpfActiveRecord
