class HTTPRedirectTest < Test::Unit::TestCase
  
  def default_test; end  # placeholder to stop Test::Unit from complaining
  
  def self.domain=(domain)
    RedirectCheck.domain = domain
  end
  
  def self.should_not_redirect(path)
    class_eval <<-CODE
      def test_#{name_for(path)}_should_not_redirect
        check = RedirectCheck.new('#{path}')
        
        assert_equal false, check.redirected?, "#{path} is redirecting"
        assert_equal true,  check.success?, "#{path} is not a success response"
      end
    CODE
  end
  
  def self.name_for(path)
    name = path.gsub(/\W+/, '_')
    name.gsub!(/^_+/, '')
    name.gsub!(/_+$/, '')
    
    name = 'root' if name == ''
    
    name
  end
  
  def self.should_redirect(source, options)
    source_path      = ResourcePath.new(source, :param => 'subdir').to_s
    destination_path = ResourcePath.new(options[:to], :param => 'subdir').to_s
    
    permanent        = options.fetch(:permanent, true)
    
    class_eval <<-CODE
      def test_#{name_for(source_path)}_should_redirect_to_#{name_for(destination_path)}
        redirection = RedirectCheck.new('#{source_path}', '#{destination_path}')
        
        assert_equal true, redirection.redirected?, "'#{source_path}' is not redirecting"
        assert_equal '#{destination_path}', redirection.redirected_path, 
                     "'#{source_path}' is not redirecting to '#{destination_path}'"
        
        if #{permanent}
          assert_equal true, redirection.permanent_redirect?, 
                       "The redirection from '#{source_path}' to '#{destination_path}' doesn't appear to be a permanent redirect"
        end
      end
    CODE

  end
  
end

