#!/usr/bin/env ruby

def cmd(cmd)
  puts cmd; system(cmd)
end


puts "--------------"
puts "Chef Chef Chef"
puts

cmd "aptitude -y update"
cmd "aptitude -y install irb ri rdoc libshadow-ruby1.8 ruby1.8-dev gcc g++ curl"

cmd "curl -L 'http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz' | tar xvzf -"
cmd "cd rubygems* && ruby setup.rb --no-ri --no-rdoc"
 
cmd "ln -sfv /usr/bin/gem1.8 /usr/bin/gem"

cmd "gem install rdoc chef ohai --no-ri --no-rdoc --source http://gems.opscode.com --source http://gems.rubyforge.org"

cmd "yes | mkfs -t ext3 /dev/sdq1"
cmd "yes | mkfs -t ext3 /dev/sdq2"

puts
puts "It seems to have worked!"
puts "------------------------"