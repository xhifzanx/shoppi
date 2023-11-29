
FROM ruby:3.0.0-alpine

WORKDIR /app

COPY . /app/

RUN apk --no-cache --no-progress --update upgrade

RUN apk --no-cache --no-progress --update --virtual add build-base tzdata libc6-compat mysql-dev nodejs npm git 


RUN bundle install
RUN npm install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]

EXPOSE 3000

