module RailsVueGenerator
  module Handlers
    class NavigationHandler < BaseHandler
      def generate
        "<router-link :to=\"{name: '#{model_name.pluralize}'}\">#{model_name.titleize}</router-link> | "
      end
    end
  end
end
