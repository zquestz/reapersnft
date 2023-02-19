# frozen_string_literal: true

namespace :docker do
  desc 'build docker images'
  task build: :environment do
    puts 'Building: reapersnft'
    puts `docker build -t reapersnft .`
  end
end
