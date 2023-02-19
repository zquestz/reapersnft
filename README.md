# ReapersNFT

## Local Development Setup
- `gem install bundler`
- `gem install rails`
- `bundle install`
- `rake` to run all tests.
- `bundle exec rake rubocop` to see rubocop offenses.
- `rails db:reset db:migrate` will reset database and reload current schema.
- `rails db:drop db:create db:migrate` will destroy the database and recreate the schema. 
- `rails assets:precompile` to precompile assets.
- `rails s` to start the server. The site will be available at `localhost:3000`.
- `bundle exec rake docker:build` to build docker image for production.
- `docker-compose up` to run production image. The site will be available at `localhost:9001`.

## Database
- In development and test environments, we use sqlite3. In production, we use postgres.