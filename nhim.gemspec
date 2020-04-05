
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nhim/version"

Gem::Specification.new do |spec|
  spec.name          = 'nhim'
  spec.version       = Nhim::VERSION
  spec.authors       = ['Khoa Nguyen']
  spec.email         = ['thanhkhoait@gmail.com']

  spec.summary       = %q{Nhim is Rails enginee for the note management (like a CMS)}
  spec.description   = %q{Nhim is Rails enginee for the note management (like a CMS)}
  spec.homepage      = 'https://github.com/ThanhKhoaIT/nhim'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/ThanhKhoaIT/nhim'
    spec.metadata['changelog_uri'] = 'https://github.com/ThanhKhoaIT/nhim'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.required_ruby_version = '~> 2.0'
  spec.require_paths = ['lib']
  spec.add_dependency 'rails'
  spec.add_dependency 'haml-rails'
  spec.add_dependency 'friendly_id'

  spec.add_development_dependency 'rails', '~> 4.2.6'
  spec.add_development_dependency 'haml-rails', '~> 2.0'
  spec.add_development_dependency 'friendly_id', '~> 5.2.4'
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
end
