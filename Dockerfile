FROM ruby:3.1.2
LABEL maintainer="quest <quest@mac.com>"

# Update image
RUN apt-get update
RUN apt-get -y upgrade

# Setup app environment
ENV APP_HOME /app
ENV HOME /root

# Copy resources to APP_HOME
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME

# Remove configs
RUN rm -rf kube

# Setup ENV to be production
ENV RAILS_ENV production

# Install all gem dependencies.
RUN gem install bundler
RUN bundle install

# Build prod assets
RUN bundle exec rake assets:precompile

ENV PORT 3000
EXPOSE 3000
CMD ["bash", "-c", "bundle exec rake db:migrate && bundle exec rails s --log-to-stdout"]
