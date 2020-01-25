Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}" }

gemspec
# TODO: move to gemspec
gem 'metanorma-acme',
  git: 'https://github.com/metanorma/metanorma-acme.git',
  branch: 'feature/config-file-extract-attributes'

if File.exist? 'Gemfile.devel'
  eval File.read('Gemfile.devel'), nil, 'Gemfile.devel' # rubocop:disable Security/Eval
end
