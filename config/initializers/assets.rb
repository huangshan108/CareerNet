# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( appointments.js )
Rails.application.config.assets.precompile += %w( salary_map.js )
Rails.application.config.assets.precompile += %w( topojson.v1.min.js )
Rails.application.config.assets.precompile += %w( queue.v1.min.js )
Rails.application.config.assets.precompile += %w( usSalaryMap.js )
Rails.application.config.assets.precompile += %w( calendar.js )
Rails.application.config.assets.precompile += %w( interviews.js )
Rails.application.config.assets.precompile += %w( d3pie.min.js )
