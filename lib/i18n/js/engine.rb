require "i18n/js"

module I18n
  module JS
    class Engine < ::Rails::Engine
      initializer "i18n-js.asset_dependencies", :after => "sprockets.environment",
                                                :before => "i18n-js.initialize" do
        Rails.application.assets.register_preprocessor "application/javascript", Preprocessor
      end
    end
  end
end
