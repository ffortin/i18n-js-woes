class Sprockets::DirectiveProcessor
  def process_depend_on_config_directive(file)
    path = File.expand_path(file, "#{Rails.root}/config")
    context.depend_on(path)
  end

  def process_depend_on_config_tree_directive(config_path)
    Dir[File.expand_path("#{config_path}/**/*", "#{Rails.root}/config")].each do |f|
      context.depend_on(f)
    end
  end
end

module I18n
  module JS
    module Engine
      class Preprocessor < ::Sprockets::Processor
        def evaluate(context, locals)
          if context.logical_path == "i18n/filtered"
            config = I18n.config_file

            context.depend_on(config) if I18n.config?
            # also set up dependencies on every locale file
            ::I18n.load_path.each {|path| context.depend_on(path)}
          end

          data
        end
      end
    end
  end
end
