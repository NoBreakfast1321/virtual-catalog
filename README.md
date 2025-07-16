# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## 🔧 Code: Formatting Files with `stree` and `RuboCop`

Use the commands below (in order) to format your application files by type:

### Controllers

```sh
bundle exec stree write app/controllers/**/*.rb
bundle exec rubocop -A app/controllers/**/*.rb
```

### Models

```sh
bundle exec stree write "app/models/**/\*.rb"
bundle exec rubocop -A "app/models/**/\*.rb"
```

### Migrations

```sh
bundle exec stree write "db/migrate/**/\*.rb"
bundle exec rubocop -A "db/migrate/**/\*.rb"
```

### Views (ERB)

```sh
bundle exec stree write --plugins=erb "app/views/**/\*.erb"
```
