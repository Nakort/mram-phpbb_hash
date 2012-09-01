# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mram-phpbb_hash/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Markus Rambossek"]
  gem.email         = ["git@rambossek.at"]
  gem.description   = %q{allows you to check a password against a phpBB 3.x hash}
  gem.summary       = %q{allows you to check a password against a phpBB 3.x hash}
  gem.homepage      = "https://github.com/mrambossek/mram-phpbb_hash"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mram-phpbb_hash"
  gem.require_paths = ["lib"]
  gem.version       = Mram::PhpbbHash::VERSION
end
