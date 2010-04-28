node[:gems].each do |gem|
  gem = {:name => gem} if gem.kind_of? String
  
  gem_package gem[:name] do
    if gem[:version] && !gem[:version].empty?
      version gem[:version]
    end
    if gem[:source]
      source gem[:source]
    end
    action :install
  end
end