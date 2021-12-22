module RailsVueGenerator
  module Handlers
    class BaseHandler
      IGNORED_COLUMNS = [:id].freeze

      def initialize(model)
        @model = model
      end

      def model_name
        @model.to_s.downcase
      end

      def generate
        lines = []
        lines << template
        lines << script
        lines << style
        lines.join("\n\n") + "\n"
      end
    end
  end
end
