task 'db:migrate' => :environment do
  ENV['RAILS_ENV'] ||= "development"
  sh "bundle exec dotenv bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --apply"
  sh "bundle exec dotenv bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --export -o Schemafile"
end

task 'db:dump' => :environment do
  ENV['RAILS_ENV'] ||= "development"
  sh "bundle exec dotenv bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --export -o Schemafile"
end