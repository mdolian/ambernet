require "rubygems"
if File.join(File.dirname(__FILE__), "bin", "common.rb")
  require File.join(File.dirname(__FILE__), "bin", "common")
end

require "merb-core"
require 'rack_hoptoad'

# Action Args
ENV["INLINEDIR"] = File.join(File.dirname(__FILE__), "tmp")
ENV["RACK_DEBUG"] = true

Merb::Config.setup(:merb_root   => ".",
                   :environment => ENV["RACK_ENV"])
Merb.environment = Merb::Config[:environment]
Merb.root = Merb::Config[:merb_root]
Merb::BootLoader.run

use Rack::HoptoadNotifier, '8f35f072dd38fab1566cc09cb8e48304'
run Merb::Rack::Application.new
