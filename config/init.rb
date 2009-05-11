require 'config/dependencies.rb'

use_orm :datamapper
use_test :rspec
use_template_engine :haml

Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = "memory"  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  c[:session_secret_key]  = '1abe9575ce925b4027e32993d446fc10569c2ce1'  # required for cookie session store
  c[:session_id_key] = '_ambernet_session_id' # cookie session id key, defaults to "_session_id"
end
  
Merb::BootLoader.before_app_loads do

end
 
Merb::BootLoader.after_app_loads do
  
end
