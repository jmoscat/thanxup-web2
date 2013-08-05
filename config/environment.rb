# Load the rails application
require File.expand_path('../application', __FILE__)
PRIVATE_DATA = YAML.load_file("#{Rails.root}/config/private.yml")[Rails.env]

# Initialize the rails application
Myinfo::Application.initialize!
