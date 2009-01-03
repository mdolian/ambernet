merb_version = "=1.0.6.1"
dm_version   = "=0.9.8"

dependency "dm-core",             dm_version, :require => "dm-core"
dependency "dm-validations",      dm_version, :require => "dm-validations"
dependency "dm-timestamps",       dm_version, :require => "dm-timestamps"
dependency "dm-migrations",       dm_version
dependency "dm-types",            dm_version, :require => "dm-types"

dependency "merb-core",             merb_version, :require => "merb-core"
dependency "merb-gen",              merb_version
dependency "merb-helpers",          merb_version, :require => "merb-helpers"
dependency "merb-haml",             merb_version, :require => "merb-haml"
dependency "merb-auth-core",        merb_version, :require => "merb-auth-core"
dependency "merb-auth-more",        merb_version, :require => "merb-auth-more"
dependency "merb-assets",           merb_version, :require => "merb-assets"
dependency "merb-slices",           merb_version, :require => "merb-slices"
dependency "merb-action-args",      merb_version, :require => "merb-action-args"
dependency "merb_datamapper",       merb_version, :require => "merb_datamapper"
dependency "merb-param-protection", merb_version, :require => "merb-param-protection"

dependency 'nokogiri', '>=1.0.6'
dependency 'webrat', '=0.3.2'
dependency "thin"
dependency 'rspec', '=1.1.11'
dependency 'rake'
dependency 'rcov'
dependency 'hoe'
dependency "extlib", "=0.9.9", :require => "extlib"
dependency "data_objects", "=0.9.9"
dependency "do_mysql", "=0.9.9"