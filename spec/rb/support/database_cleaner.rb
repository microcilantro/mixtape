require 'database_cleaner/sequel'  # Updated require path

DatabaseCleaner[:sequel, db: Sequel::Model.db].strategy = :transaction

RSpec.configure do |config|
  config.around do |example|
    DatabaseCleaner[:sequel, db: Sequel::Model.db].start
    example.run
    DatabaseCleaner[:sequel, db: Sequel::Model.db].clean
  end
end
