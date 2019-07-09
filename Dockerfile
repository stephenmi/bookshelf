FROM ruby:2.5.5
RUN apt-get update -qq && apt-get install -y nodejs
RUN mkdir /book_shelf
WORKDIR /book_shelf
ADD Gemfile /book_shelf/Gemfile
ADD Gemfile.lock /book_shelf/Gemfile.lock
RUN bundle install
ADD . /book_shelf
CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]