require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'act_as_cnpj_cpf'
require 'cpf_faker'

RSpec.configure do |config|
  config.order = :random
end
