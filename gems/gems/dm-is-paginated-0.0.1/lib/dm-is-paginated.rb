# Needed to import datamapper and other gems
require 'rubygems'
require 'pathname'

# Add all external dependencies for the plugin here
gem 'dm-core', '>=0.9.4'
require 'dm-core'

# Require plugin-files
dir = Pathname(__FILE__).dirname.expand_path / 'dm-is-paginated'
require dir / "hash"
require dir / 'is' / 'paginated'

# Include the plugin in Resource
module DataMapper
  module Resource
    module ClassMethods
      include DataMapper::Is::Paginated
    end # module ClassMethods
  end # module Resource
end # module DataMapper