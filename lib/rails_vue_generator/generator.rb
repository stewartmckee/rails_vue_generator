

module RailsVueGenerator
  class Generator
    ROOT_PATH = File.join(Dir.getwd, "vue_example")

    def self.generate
      ModelGenerator.new.generate

      RouterGenerator.new.generate
      NavigationGenerator.new.generate
      ApiGenerator.new.generate
      StoreGenerator.new.generate
    end
  end
end
