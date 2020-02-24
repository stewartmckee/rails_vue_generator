module RailsVueGenerator
  class ApiGenerator < BaseGenerator  

    def initialize(options = {})
      options[:path] = File.join(Generator::ROOT_PATH, "src", "api") unless options.key?(:path)
      @options = options  
    end

    def generate
      FileUtils.mkdir_p(@options[:path])
      index_lines = []
      models.each do |model|
        index_lines << "import #{model.to_s.downcase} from '@/api/#{model.to_s.downcase}'"
      end
      index_lines << ""
      index_lines << "export default {"
      models.each do |model|
        index_lines << "  #{model.to_s.downcase}: #{model.to_s.downcase},"
      end 
      index_lines << "}"
      File.write(File.join(@options[:path], "index.js"), index_lines.join("\n") )
      
      models.map{|model| File.write(File.join(@options[:path], "#{model.to_s.downcase}.js"), Handlers::ApiHandler.new(model).generate) }
    end

  end
end