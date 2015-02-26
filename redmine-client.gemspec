# -*- encoding: utf-8 -*-
#
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'redmine-client'
  s.version     = File.read(File.expand_path('../VERSION', __FILE__)).strip
  s.authors     = ['nine.ch Development-Team']
  s.email       = ['development@nine.ch']
  s.homepage    = 'http://github.com/ninech/'
  s.license     = 'MIT'
  s.summary     = 'Redmine API ruby client library'
  s.description = 'To access the Redmine API from ruby scripts.'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'

  s.add_runtime_dependency 'httparty'
  s.add_runtime_dependency 'webmock', '~> 1.18.0'
  s.add_runtime_dependency 'activesupport', '> 3.0.0'
  s.add_runtime_dependency 'pry', '~> 0.10.0'
end
