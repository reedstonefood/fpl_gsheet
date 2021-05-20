
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fpl_gsheet/version"

Gem::Specification.new do |spec|
  spec.name          = "fpl_gsheet"
  spec.version       = FplGsheet::VERSION
  spec.authors       = ["reedstonefood"]
  spec.email         = ["reedstonefood@users.noreply.github.com"]

  spec.summary       = %q{Get Premier League Fantasy Football data into Google Sheets.}
  spec.description   = %q{Data comes from fantasy.premierleague.com.}
  spec.homepage      = "https://github.com/reedstonefood"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "google_drive", "~> 2.1"
  spec.add_dependency "recursive-open-struct", "~> 1.1"
  spec.add_dependency "nokogiri", ">= 1.10.10", "< 1.12.0"
end
