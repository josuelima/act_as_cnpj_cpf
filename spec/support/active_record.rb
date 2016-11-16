ActiveRecord::Base.establish_connection adapter:  'sqlite3', 
                                        database: 'cnpj_cpf_spec.sqlite3'

ActiveRecord::Migration.drop_table :cnpj_cpf_test if ActiveRecord::Base.connection.data_source_exists? :cnpj_cpf_test
ActiveRecord::Migration.create_table :cnpj_cpf_test do |t|
  t.string 'codigo'
end

RSpec.configure do |config|
  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end
