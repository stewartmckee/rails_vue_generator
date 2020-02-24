module RailsVueGenerator
  class StoreGenerator < BaseGenerator  

    def initialize(options = {})
      options[:path] = File.join(Generator::ROOT_PATH, "src", "store") unless options.key?(:path)
      @options = options  
    end

    def generate
      FileUtils.mkdir_p(@options[:path])
      FileUtils.mkdir_p(File.join(@options[:path], "modules"))
      index_lines = []

      index_lines << "import Vue from 'vue'"
      index_lines << "import Vuex from 'vuex'"
      models.each do |model|
        index_lines << "import #{model.to_s.downcase} from '@/store/modules/#{model.to_s.downcase}'"
      end
      index_lines << ""
      index_lines << "Vue.use(Vuex)"
      index_lines << ""
      index_lines << "export default new Vuex.Store({"
      index_lines << "  modules: {"
      index_lines << "    #{models.map{|model| model.to_s.downcase}.join(", ")}"
      index_lines << "  }"
      index_lines << "})"
      File.write(File.join(@options[:path], "index.js"), index_lines.join("\n") )
      
      models.map{|model| File.write(File.join(@options[:path], "modules", "#{model.to_s.downcase}.js"), Handlers::StoreHandler.new(model).generate) }
    end

  end
end