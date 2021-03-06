module Kashmir
  module Dsl

    def self.included(klass)
      klass.extend ClassMethods 
    end

    module ClassMethods

      def prop(name)
        definitions << name
      end

      def props(*names)
        names.each do |name|
          prop(name)
        end
      end

      def group(name, fields)
        definition = Hash.new
        definition[name] = fields
        definitions << definition
      end

      def embed(name, representer)
        group(name, representer.definitions) 
      end

      def inline(name, &inline_representer)
        representer = Kashmir::InlineDsl.build(&inline_representer)
        embed(name, representer) 
      end

      def definitions
        @definitions ||= []
        @definitions
      end
    end
  end
end
