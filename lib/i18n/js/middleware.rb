module I18n
  module JS
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        ::I18n::JS.export
        @app.call(env)
      end
    end
  end
end
