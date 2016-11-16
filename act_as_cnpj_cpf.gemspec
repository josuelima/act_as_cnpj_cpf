# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'act_as_cnpj_cpf/version'

Gem::Specification.new do |gem|
  gem.name         = 'act_as_cnpj_cpf'
  gem.version      = ActAsCnpjCpf::VERSION
  gem.platform     = Gem::Platform::RUBY
  gem.authors      = ['Josué Lima']
  gem.email        = ['josuedsi@gmail.com']
  gem.summary      = %q{Permite formatar e validar um atributo ActiveRecord como CPF, CNPJ ou ambos}
  gem.description  = gem.summary
  gem.license      = 'MIT'
  gem.homepage     = 'https://github.com/josuelima/act_as_cnpj_cpf'

  gem.files        = `git ls-files`.split("\n")
  gem.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables  = `git ls-files -- bin/*`.split('\n').map { |f| File.basename(f) }

  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 2.0.0'
  
  gem.add_dependency 'activesupport', ["~> 5.0"]
  gem.add_dependency 'activerecord',  ["~> 5.0"]
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'cpf_faker', '~> 1.3'
  gem.add_development_dependency 'sqlite3', '~> 1.3'
end
