module RailsVueGenerator
  class NavigationGenerator < BaseGenerator
    def initialize(options = {})
      options[:path] = File.join(Generator::ROOT_PATH, "src", "components") unless options.key?(:path)
      options[:filename] = "navigation.vue" unless options.key?(:filename)
      @options = options
    end

    def generate
      FileUtils.mkdir_p(@options[:path])
      File.write(File.join(@options[:path], @options[:filename]), "<template><div>" + models.map { |model| Handlers::NavigationHandler.new(model).generate }.join("\n") + "</div></template>")
    end
  end
end
