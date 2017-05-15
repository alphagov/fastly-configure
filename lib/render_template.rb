require 'yaml'

class RenderTemplate
  def self.render_template(configuration, environment, config, version)
    # Both config and ab_tests are used inside the vcl.erb template
    vcl_file = File.join(File.dirname(__FILE__), '..', 'vcl_templates', "#{configuration}.vcl.erb")
    ab_tests = YAML.load_file(File.join(__dir__, '..', 'ab_tests', 'ab_tests.yaml'))
    ERB.new(File.read(vcl_file), nil, '-').result(binding)
  end
end
