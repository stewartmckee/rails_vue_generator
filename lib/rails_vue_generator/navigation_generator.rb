module RailsVueGenerator
  class NavigationGenerator < BaseGenerator
    def initialize(options = {})
      options[:path] = File.join(Generator::ROOT_PATH, "src", "components") unless options.key?(:path)
      options[:filename] = "navigation.vue" unless options.key?(:filename)
      @options = options
    end

    def generate
      FileUtils.mkdir_p(@options[:path])

      nav_text = []
      nav_text << "<template>"
      nav_text << "  <div>"
      nav_text << models.map { |model| "    #{Handlers::NavigationHandler.new(model).generate}" }.join("\n")
      nav_text << "  </div>"
      nav_text << "</template>"

      File.write(File.join(@options[:path], @options[:filename]), nav_text.join)
    end
  end
end
