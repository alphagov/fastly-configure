class RenderTemplate
  def self.render_template(configuration, environment, config, version)
    vcl_file = File.join(File.dirname(__FILE__), '..', 'vcl_templates', "#{configuration}.vcl.erb")
    ERB.new(File.read(vcl_file), nil, '-').result(binding)
  end
end
