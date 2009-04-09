# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{merb-pagination}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lori Holden"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDPjCCAiagAwIBAgIBADANBgkqhkiG9w0BAQUFADBFMRIwEAYDVQQDDAllbWFp\nbF9nZW0xGjAYBgoJkiaJk/IsZAEZFgpsb3JpaG9sZGVuMRMwEQYKCZImiZPyLGQB\nGRYDY29tMB4XDTA4MDgxNzE5NDYxNloXDTA5MDgxNzE5NDYxNlowRTESMBAGA1UE\nAwwJZW1haWxfZ2VtMRowGAYKCZImiZPyLGQBGRYKbG9yaWhvbGRlbjETMBEGCgmS\nJomT8ixkARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALQM\n9M25zHpF8F4h2/u3lTGdmvJpmoTNmWZn4yoebqoRjwXYC2i5RxIqHAQi0LuI7ZPA\nf7vyH49p3Ozc/xPiDVXtwduTHtAYHEqTk4WeFUZnMk8sgRFz2EXNtoMLBmMp5XAo\nqu0f+vH3mTxas1WR8v1iZIkcyQo6o110peBMS+fOXOFHOjbcbT3ExMDGUM8229Y4\nqa+1ddMXdm35KK9lcZFdtAwecxTaf4ZLUS+83FmL0YNCSIjXUX4Oi1fWGIT9dr/o\nAYRTLYM5gj5W0NKmr1M6wshJIuh0Owg3UczID7Ogfg5kHHaUxaS9a/NXS3Cw91lY\nA54wYDc/GBtLDtb5aqcCAwEAAaM5MDcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAw\nHQYDVR0OBBYEFLvrumPKVz6D0iqqxQULDeJGp6w9MA0GCSqGSIb3DQEBBQUAA4IB\nAQCigiinxPWn1dOiP4XLwvixFcx/rK0ltpDZ0ja9RXmntUvExqnsX3mCX+W74GMz\nMrZKb/S5AAS5n2EoYuvDEwxn34ddkqXiXravRLzd8Jw1/kWE9wdTsF+KB/SngBb/\n0mWxe6XHD6DQ+6DNhyY+uZOsFiAXxh+Hu0MZTb9xFB/jXIy9B6+rdjwMlxwIfaQn\nD5rkGZJKg3MlIKhDnmTEfU5JmwgAH1+v1gbUbUnOrTGMe8JkEd0h4q9Bl46ydIIH\nWcfEbGXaBPnC8f8KOa6s8BMIrqW0z8SvlsNIvHZSvRbWf3Sjey10MSFuTYJX2D1/\nUXRgWS//g7odGv0eT+GJBEUt\n-----END CERTIFICATE-----\n"]
  s.date = %q{2008-08-19}
  s.description = %q{A pagination helper for merb}
  s.email = ["email+gem@loriholden.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "website/index.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "lib/merb-pagination.rb", "lib/merb-pagination/hash.rb", "lib/merb-pagination/pagination_helper.rb", "lib/merb-pagination/version.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/website.rake", "test/test_helper.rb", "test/test_merb-pagination.rb", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://merb-pagination.rubyforge.org/}
  s.post_install_message = %q{
For more information on merb_pagination, see:
 http://projects.loriholden.com/wiki/merb_pagination


}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb-pagination}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A pagination helper for merb}
  s.test_files = ["test/test_helper.rb", "test/test_merb-pagination.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb-core>, [">= 0.9.4"])
      s.add_runtime_dependency(%q<builder>, [">= 2.0.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<merb-core>, [">= 0.9.4"])
      s.add_dependency(%q<builder>, [">= 2.0.0"])
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<merb-core>, [">= 0.9.4"])
    s.add_dependency(%q<builder>, [">= 2.0.0"])
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
