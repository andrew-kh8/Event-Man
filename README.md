# README


## Start
copy .env from .env.sample and fill it

copy Procfile.dev from Procfile.dev.sample and configure it. Then run

`bin/dev`



## System dependencies

**PostgreSQL** - бд, без нее никуда )
**Geoserver** - необходим для работы с геоданными. Без него будет показываться просто пустая карта, без возможности просмотра точек из БД.

Инструкция по установке - https://geoserver.org/download/

Инструкция по настройке - [docs.google.com/document](https://docs.google.com/document/d/1-3L9uSeURUI4rmYkArT6ycBN7JQvhUnONboK4brn2dY/edit?tab=t.0#heading=h.4aa3v1m8xv8l)



## Developing

После/во время написания кода не забывайте пользоваться инструментами что проверки и мониторинга кода/тестов :)

Почти все из них используются в CI

1) `rubocop` - линтер
2) `rspec` - тесты
3) `rubycritic` - различные метрики (покрытие тестами, code smells и тд)
4) `brakeman` - уязвимости
5) `bundler-audit` - версии гемов
6) `active_record_doctor` и `database_consistency` - консистентность БД



## Tests

На проекте используются rspec + capybara

Для проверки покрытия - simplecov

Для проверки правильности написания тестов - rubocop plugins

```
rspec

rubycritic # для просмотра статистики
```



## GitHub actions

На данный момент настроен след флоу при создании ПР или пуше в мастер:

```
   scan ruby--\
   scan js-----+---> scan_database---> tests
   lint-------/
```

Он позволяет проверить важные аспекты проекта начиная от простого (линтера) и заканчивая более тяжелым (тесты)

для вызова гема в CI следует выполнить одно из двух:
1) при вызове прописывать `bundle exec`
2) 
   * создать binstubs файл через `bundle binstubs gemname`
   * тогда при вызове прописывать `bin/gemname` который был создан

