# frozen_string_literal: true

require_relative "lib/utility_colors/version"

Gem::Specification.new do |spec|
  spec.name = "utility_colors"
  spec.version = UtilityColors::VERSION
  spec.authors = ["Louis W Davis"]
  spec.email = ["louiswilliamdavis@gmail.com"]

  spec.summary = "The last time to worry about color palette styles"
  spec.description = "Creates all the color palettes classes you need from your colors"
  spec.homepage = "https://github.com/louiswdavis/utility_colors"
  spec.license = "MIT"
  # spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/louiswdavis/utility_colors/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
