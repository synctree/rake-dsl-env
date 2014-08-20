require 'rake/configuration'
require 'rake/dsl/env/version'

module Rake
  module DSL
    module Env
      def fetch(key, default=nil, &block)
        env.fetch(key, default, &block)
      end

      def any?(key)
        value = fetch(key)
        if value && value.respond_to?(:any?)
          value.any?
        else
          !value.nil?
        end
      end

      def set(key, value)
        env.set(key, value)
      end

      def delete(key)
        env.delete(key)
      end

      def ask(key, value, options={})
        env.ask(key, value, options)
      end

      def env
        Rake::DSL::Env.config_class.env
      end

      class << self
        def config_class
          @config_class ||= Configuration
        end

        def config_class=(klass)
          @config_class = klass
        end
      end
    end
  end
end
self.extend Rake::DSL::Env
