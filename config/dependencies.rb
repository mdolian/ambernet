merb_gems_version = "1.0.9"
dm_gems_version   = "0.9.10"
do_gems_version   = "0.9.11"

dependency "merb-assets", merb_gems_version  
dependency "merb-helpers", merb_gems_version 
dependency "merb-param-protection", merb_gems_version
dependency "merb_datamapper", merb_gems_version
dependency "merb-haml", merb_gems_version
dependency "merb-gen", merb_gems_version
dependency "merb-cache", merb_gems_version   
#dependency "merb-mailer", merb_gems_version  
#dependency "merb-slices", merb_gems_version  
#dependency "merb-auth-core", merb_gems_version
#dependency "merb-auth-more", merb_gems_version
#dependency "merb-auth-slice-password", merb_gems_version
#dependency "merb-exceptions", merb_gems_version

dependency "data_objects", do_gems_version
dependency "do_mysql", do_gems_version
dependency "dm-core", dm_gems_version         
dependency "dm-aggregates", dm_gems_version   
dependency "dm-serializer", dm_gems_version   
#dependency "dm-migrations", dm_gems_version   
#dependency "dm-timestamps", dm_gems_version   
#dependency "dm-types", dm_gems_version        
#dependency "dm-validations", dm_gems_version  

dependency "nokogiri"
dependency "webrat"
dependency "thin"
dependency "rake"
dependency "rcov"
dependency "haml"
dependency "extlib"
dependency "dm-is-paginated"
dependency "merb-pagination"
