if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'act_as_cnpj_cpf'
require 'cpf_faker'
require 'support/active_record'

RSpec.configure do |config|
  config.color = true
  config.tty   = true
  config.order = :random
end
