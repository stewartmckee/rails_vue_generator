module RailsVueGenerator
  class ModelGenerator < BaseGenerator
    def initialize(options = {})
      options[:path] = File.join(Generator::ROOT_PATH, "src", "views") unless options.key?(:path)
      @options = options
    end

    def generate
      models.map do |model|
        FileUtils.mkdir_p(File.join(@options[:path], model.to_s.downcase))
        puts "Writing #{File.join(@options[:path], model.to_s.downcase, "index.vue")}"
        puts File.write(File.join(@options[:path], model.to_s.downcase, "index.vue"), Handlers::IndexHandler.new(model).generate)
        puts "Writing #{File.join(@options[:path], model.to_s.downcase, "show.vue")}"
        puts File.write(File.join(@options[:path], model.to_s.downcase, "show.vue"), Handlers::ShowHandler.new(model).generate)
        puts "Writing #{File.join(@options[:path], model.to_s.downcase, "edit.vue")}"
        puts File.write(File.join(@options[:path], model.to_s.downcase, "edit.vue"), Handlers::EditHandler.new(model).generate)
      end
    end
  end
end
