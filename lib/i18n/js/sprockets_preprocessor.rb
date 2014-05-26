class Sprockets::DirectiveProcessor
  def process_depend_on_config_directive(file)
    path = File.expand_path(file, "#{Rails.root}/config")
    context.depend_on(path)
  end

  def process_depend_on_config_tree_directive(config_path)
    Dir[File.expand_path(config_path, "#{Rails.root}/config")].each do |f|
      context.depend_on(f)
    end
  end
end