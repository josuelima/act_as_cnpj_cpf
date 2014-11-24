if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'act_as_cnpj_cpf'
require 'cpf_faker'
require 'support/active_record'

# shared samples
require 'support/cnpj_cpf_base_spec'

RSpec.configure do |config|
  config.color = true
  config.tty   = true
end
