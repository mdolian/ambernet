namespace :gems do
  
  desc "Install any custom gems"
  task :install_custom do
    sh "cd /tmp && git clone git://github.com/mislav/will_paginate.git"
    sh "cd /tmp/will_paginate && git checkout --track -b agnostic origin/agnostic"
    sh "cd /tmp/will_paginate && gem build will_paginate.gemspec"
    sh "cd /tmp/will_paginate && sudo gem install will_paginate-3.0.0.gem --no-ri --no-rdoc"
  end
end 