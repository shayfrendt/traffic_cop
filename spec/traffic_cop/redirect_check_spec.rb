require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RedirectCheck do
  context "#domain" do
    it "sets the domain" do
      RedirectCheck.domain = 'example.com'
      RedirectCheck.domain.should == 'example.com'
    end
  end
  
  context "#uri" do
    it "returns the parsed URI" do
      RedirectCheck.domain = 'example.com'
      RedirectCheck.new('/blog').uri.host.should == "example.com"
      RedirectCheck.new('/blog').uri.path.should == "/blog"
    end
  end
end
