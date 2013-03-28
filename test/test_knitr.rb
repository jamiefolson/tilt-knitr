require File.expand_path('../helper', __FILE__)

describe Tilt::KnitrTemplate do
	it "registered for '.Rmd' files" do
		assert_equal Tilt::KnitrTemplate, Tilt["test.Rmd"]
	end
	
	it "loading and evaluating templates on #render" do
    template = Tilt::KnitrTemplate.new { |t| "Hello World!" }
    assert_equal "Hello World!", template.render
  end
	
	it "basics" do
		template = Tilt::KnitrTemplate.new { "```{r echo=FALSE, results='asis'}\ncat(6 * 6)\n```" }
		assert_equal "36", template.render
  end
	
end
