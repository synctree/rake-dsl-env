require_relative 'configuration/question'

module Rake
  class Configuration
    class << self
      def env
        @env ||= new
      end

      def reset!
        @env = new
      end
    end

    def ask(key, default=nil, options={})
      question = Question.new(self, key, default, options)
      set(key, question)
    end

    def set(key, value)
      config[key] = value
    end

    def delete(key)
      config.delete(key)
    end

    def fetch(key, default=nil, &block)
      value = fetch_for(key, default, &block)
      while callable_without_parameters?(value)
        value = set(key, value.call)
      end
      return value
    end

    def keys
      config.keys
    end

    private

    def config
      @config ||= Hash.new
    end

    def fetch_for key, default, &block
      if block_given?
        config.fetch(key, &block)
      else
        config.fetch(key, default)
      end
    end

    def callable_without_parameters?(x)
      x.respond_to?(:call) && ( !x.respond_to?(:arity) || x.arity == 0)
    end
  end
end
