require 'spec_helper'
require_relative './../lib/render_template'

RSpec.describe RenderTemplate do
  describe ".render_template" do
    it "renders the ERB template" do
      result = RenderTemplate.render_template("test", {}, "my_variable", {})

      expect(result).to eql("my_variable\n")
    end
  end
end
