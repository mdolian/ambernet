# Needed to import merb and other gems
require 'rubygems'
require 'pathname'

# Add all external dependencies for the plugin here
gem 'merb-core', '>=0.9.4'
require 'merb-core'

# Require plugin-files
dir = Pathname(__FILE__).dirname.expand_path / 'merb-pagination'
require dir / "hash"
require dir / 'pagination_helper'

Merb::Controller.send(:include, Merb::PaginationHelper)