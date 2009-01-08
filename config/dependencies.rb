merb_version = "=1.0.7.1"
dm_version   = "=0.9.8"

dependency "dm-core",             dm_version
dependency "dm-validations",      dm_version
dependency "dm-timestamps",       dm_version
dependency "dm-migrations",       dm_version
dependency "dm-types",            dm_version

dependency "merb-core",             merb_version
dependency "merb-gen",              merb_version
dependency "merb-helpers",          merb_version
dependency "merb-haml",             merb_version
dependency "merb-auth-core",        merb_version
dependency "merb-auth-more",        merb_version
dependency "merb-assets",           merb_version
dependency "merb-slices",           merb_version
dependency "merb-action-args",      merb_version
dependency "merb_datamapper",       merb_version
dependency "merb-param-protection", merb_version

dependency 'nokogiri', '>=1.0.6'
dependency 'webrat', '=0.3.2'
dependency "thin"
dependency 'rake'
dependency 'rcov'
dependency 'hoe'
dependency 'haml'
dependency "extlib", "=0.9.9"
dependency "data_objects", "=0.9.9"
dependency "do_mysql", "=0.9.9"