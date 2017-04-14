# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'protonbot/memos'

Gem::Specification.new do |spec|
  spec.name          = "protonbot-memos"
  spec.version       = ProtonBot::Memos::VERSION
  spec.authors       = ["Nickolay Ilyushin"]
  spec.email         = ["nickolay02@inbox.ru"]

  spec.summary       = 'Memo plugin for ProtonBot'
  spec.description   = 'Memo plugin for ProtonBot'
  spec.homepage      = 'https://github.com/handicraftsman/protonbot-memos'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

   spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'protonbot', '>= 0.2.2'
end
