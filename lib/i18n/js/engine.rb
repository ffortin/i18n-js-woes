require "i18n/js"

module I18n
  module JS

    class Engine < ::Rails::Engine
      initializer "i18n-js.asset_dependencies", :after => "sprockets.environment",
                                                :before => "i18n-js.initialize" do
        Rails.application.assets.register_preprocessor "application/javascript", ::I18n::JS::Preprocessor
      end
    end

    class Preprocessor < ::Sprockets::Processor
      def evaluate(context, locals)
        if context.logical_path == "i18n/filtered"
          config = ::I18n::JS.config_file

          context.depend_on(config) if ::I18n::JS.config?
          # also set up dependencies on every locale file
          ::I18n.load_path.each {|path| context.depend_on(path)}
        end

        data
      end
    end
  end
end
