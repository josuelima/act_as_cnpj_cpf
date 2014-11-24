if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'act_as_cnpj_cpf'
require 'cpf_faker'
require 'support/active_record'

# shared samples
require 'support/cnpj_cpf_active_record_shared'
require 'support/cnpj_cpf_base_shared'

# silence warnings about i18n validation deprecations
I18n.config.enforce_available_locales = true

RSpec.configure do |config|
  config.color = true
  config.tty   = true
end
