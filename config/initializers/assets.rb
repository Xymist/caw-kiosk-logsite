# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( noVNC/util.js )
Rails.application.config.assets.precompile += %w( noVNC/webutil.js )
Rails.application.config.assets.precompile += %w( noVNC/base64.js )
Rails.application.config.assets.precompile += %w( noVNC/websock.js )
Rails.application.config.assets.precompile += %w( noVNC/des.js )
Rails.application.config.assets.precompile += %w( noVNC/input.js )
Rails.application.config.assets.precompile += %w( noVNC/display.js )
Rails.application.config.assets.precompile += %w( noVNC/rfb.js )
Rails.application.config.assets.precompile += %w( noVNC/jsunzip.js )
Rails.application.config.assets.precompile += %w( noVNC/playback.js )
Rails.application.config.assets.precompile += %w( noVNC/ui.js )
Rails.application.config.assets.precompile += %w( noVNC/logo.js )
