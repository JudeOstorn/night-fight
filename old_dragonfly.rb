require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "c853056e9b5bc1dcc709355307048805bb552c52583fcadd6f85320b25a4871d"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end

processor :gallery_small do |content|
    content.process!(:convert, "-resize '263x183^' -gravity center -crop 263x183+0+0 -quality '80%' -strip")
    content.process!(:encode, 'jpg')
  end
