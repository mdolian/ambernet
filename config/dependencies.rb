add_source "http://gems.rubyforge.org/"

add_gem 'rspec', '=1.1.11'
add_gem 'rake'
add_gem 'rcov'
add_gem 'thin'
add_gem 'hoe'

add_dependency "extlib", "=0.9.9", :require => "extlib"
add_gem "data_objects", "=0.9.9"
add_gem "do_mysql", "=0.9.9"

merb_version = "=1.0.6.1"
dm_version   = "=0.9.8"

add_dependency "dm-core",             dm_version, :require => "dm-core"
add_dependency "dm-validations",      dm_version, :require => "dm-validations"
add_dependency "dm-timestamps",       dm_version, :require => "dm-timestamps"
add_dependency "dm-migrations",       dm_version
add_dependency "dm-types",            dm_version, :require => "dm-types"

add_dependency "merb-core",             merb_version, :require => "merb-core"
add_dependency "merb-gen",              merb_version
add_dependency "merb-helpers",          merb_version, :require => "merb-helpers"
add_dependency "merb-haml",             merb_version, :require => "merb-haml"
add_dependency "merb-auth-core",        merb_version, :require => "merb-auth-core"
add_dependency "merb-auth-more",        merb_version, :require => "merb-auth-more"
add_dependency "merb-assets",           merb_version, :require => "merb-assets"
add_dependency "merb-slices",           merb_version, :require => "merb-slices"
add_dependency "merb-action-args",      merb_version, :require => "merb-action-args"
add_dependency "merb_datamapper",       merb_version, :require => "merb_datamapper"
add_dependency "merb-param-protection", merb_version, :require => "merb-param-protection"

add_dependency 'nokogiri', '>=1.0.6'
add_dependency 'webrat', '=0.3.2'
