module RailsVueGenerator
  class RouterGenerator < BaseGenerator
    def initialize(options = {})
      options[:path] = File.join(Generator::ROOT_PATH, "src", "router") unless options.key?(:path)
      options[:filename] = "index.js" unless options.key?(:filename)
      @options = options
    end

    def generate
      FileUtils.mkdir_p(@options[:path])
      routes = []
      models.each do |model|
        routes += Handlers::RouterHandler.new(model).generate
      end
      File.write(File.join(@options[:path], @options[:filename]), "import Vue from 'vue'\nimport VueRouter from 'vue-router'\nVue.use(VueRouter)\nconst routes = [\n" + routes.join + "\n]\nconst router = new VueRouter({\nmode: 'history',\nbase: process.env.BASE_URL,\nroutes\n})\nexport default router\n")
    end
  end
end
