# Sklad

### Описание

Петс-проект для мелкого магаза для отображения текущих остатков

### Ruby version

```
ruby 3.1.2
```

### Rails version

```
rails 6.1.7
```

Sqlite3 version

```
sqlite3 1.4
```

## Первый запуск

```
gem install bundler
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
copy .env.template .env
```

Заполнить переменные окружения в `.env`

### Загрузить данные

```
bundle exec rake import:operation_types_from_sklad_prg
bundle exec rake import:users_from_sklad_xlsx
bundle exec rake import:operation_from_log
bundle exec rake import:replays_from_txt
bundle exec rake import:product_from_sklad
```

### Запуск сервера

```
bundle exec rails s
```
