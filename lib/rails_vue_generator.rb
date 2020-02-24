require "rails_vue_generator/version"
require "rails_vue_generator/handlers/base_handler"
require "rails_vue_generator/handlers/index_handler"
require "rails_vue_generator/handlers/show_handler"
require "rails_vue_generator/handlers/edit_handler"
require "rails_vue_generator/handlers/router_handler"
require "rails_vue_generator/handlers/navigation_handler"
require "rails_vue_generator/handlers/api_handler"
require "rails_vue_generator/handlers/store_handler"

require "rails_vue_generator/generator"

require "rails_vue_generator/base_generator"
require "rails_vue_generator/model_generator"
require "rails_vue_generator/navigation_generator"
require "rails_vue_generator/router_generator"
require "rails_vue_generator/api_generator"
require "rails_vue_generator/store_generator"

module RailsVueGenerator
  class Error < StandardError; end
end
