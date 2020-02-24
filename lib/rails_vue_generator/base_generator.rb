module RailsVueGenerator
  class BaseGenerator
    IGNORED_CONSTANTS = %i[Fixnum Bignum SourceAnnotationExtractor NIL Data TRUE FALSE TimeoutError].freeze

    def models
      Module.constants.reject { |c| IGNORED_CONSTANTS.include?(c) }.select do |constant_name|
        constant = eval constant_name.to_s
        if !constant.nil? && constant.is_a?(Class) && (constant.superclass == ApplicationRecord)
          constant
        end
      end.map { |c| eval c.to_s }
    end
  end
end
