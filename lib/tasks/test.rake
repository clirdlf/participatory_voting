# frozen_string_literal: true

namespace :test do
  desc 'Run the lint tests'
  task lint: :environment do
    system('bin/bundler-audit --update')
    system('bin/brakeman -q -w2')
    system('bin/rubocop --parallel')
  end
end
