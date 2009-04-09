# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sanitize}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Grove"]
  s.date = %q{2009-02-23}
  s.email = %q{ryan@wonko.com}
  s.files = ["HISTORY", "LICENSE", "README.rdoc", "lib/sanitize.rb", "lib/sanitize/config.rb", "lib/sanitize/config/basic.rb", "lib/sanitize/config/relaxed.rb", "lib/sanitize/config/restricted.rb"]
  s.homepage = %q{http://github.com/rgrove/sanitize/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Whitelist-based HTML sanitizer.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, ["~> 0.6"])
    else
      s.add_dependency(%q<hpricot>, ["~> 0.6"])
    end
  else
    s.add_dependency(%q<hpricot>, ["~> 0.6"])
  end
end
