require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bloom
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Dir.glob(File.join("#{Rails.root}/app/lib", '**', '*.rb'), &method(:require))
    # 
    # require_all "#{Rails.root}/app/lib"

    config.autoload_paths += [
      "#{Rails.root}/app/lib/",
      "#{Rails.root}/app/lib/plant_grid",
      "#{Rails.root}/app/lib/plant_grid/grid_cells",
      "#{Rails.root}/app/lib/plant_grid/position_patterns",
      "#{Rails.root}/app/lib/plant_grid/template_definitions"]
    # config.autoload_paths += ["#{Rails.root}/app/lib/**/*"]
    config.watchable_dirs["#{Rails.root}/app/lib"] = [:rb]
    config.watchable_dirs["#{Rails.root}/app/lib/plant_grid"] = [:rb]
    config.watchable_dirs["#{Rails.root}/app/lib/plant_grid/grid_cells"] = [:rb]
    config.watchable_dirs["#{Rails.root}/app/lib/plant_grid/position_patterns"] = [:rb]
    config.watchable_dirs["#{Rails.root}/app/lib/plant_grid/template_definitions"] = [:rb]
  end
end
