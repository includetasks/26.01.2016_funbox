#### Q4. Расскажите об используемых Вами фреймворках (программных каркасах). В чем их плюсы? Для каких задач лучше использовать существующий фреймворк, а когда лучше все написать самому?

---

Из полноценных фрэймворков я пользовался Ruby on Rails, Sinatra и RSpec. Ruby on Rails / Sinatra - разработка web-сервисов/web-приложений. RSpec - фрэймворк, предназначенный для тестирования приложений, написанных на Ruby.
Плюсы ***Rails*** скорее в том, что почти всё из области разработки Web-приложений - *'из коробки'* (назову некоторые из них):

- Convention over Configuration (bestpractics уже изучены и жёстко вшиты в фрэймворк, разрабатывая на Rails чаще всего вы не будете иметь особых проблем, когдая включаетесь в новый для себя проект);
- прозрачний live-reload кода при разработке;
- множество enviroment'ов (production / testing / develompent из коробки);
- логгирование (приятно наблюдать в development в консоли realtime-логи sql-запросов от ActiveRecord'ов);
- кодогенерация (для себя выделяю удобство в controller / model / migrations / specs);
- ресурсный роутинг (маппинг url на контроллеры без головной боли за реализацию);
- в счет своей популярности, имеет хорошую поддержку различными редакторами кода (RubyMine очень хорошо подхватывает проекты на RoR; например: имеет плагин, позволяющий вывести список роутов с их шаблонами в отдельном окне, а по двойному клику - перейти в место в коде соответствующего контроллера);
- background tasks (пока не пользовался, только немного читал (ActiveJob (Sidekiq)), но выделю это для себя как отдельный плюс, т.к. грамотный подход к работе с фоновыми задачами приживается рельсами своей собственной реализацией);
- DRY всего, что можно, и пропаганда этого по максимуму (от чего множество типовых задач уже решены и доступны в виде гема или плагина);

Конечно, если Rails чем-то не устраевает или не отвечает вашим требованиям, можно воспользоваться Sinatra. Sinatra позиционирую для себя как framework для конструирования своего кастомного комбайна (аля ArchLinux или BackboneJS).

***RSpec*** - тестирование приложений, написанных на Ruby. Из плюсов для себя выделяю:

- лаконичный DSL - describe / context / it / expect;
- большое количество матчеров (to be, to change, not_to, eq, etc);
- расширяем (возможно написание своих собственных матчеров);
- в виду своей вездесущности и de-facto-стандартности, реализована поддержка интегрируемости почти во всё, что можно (с соответствующими матчерами);
- lazy-loading тестовых данных с их кешированием (let);

Когда следует использовать существующий фреймворк, а когда - свою собственную реализацию:

- необходимо сэкономить время на реализацию продукта - **используем существующий framework**.
- архитектура проекта очевидна и стандартна, когда ваш набор требований к продукту покрывается конкретным фреймворком - **используем существующий framework**.
- необходимо реализовывать часто используемую фичу (наример, работу со временем) - **используем существуюю библиотечку, иначе - своя реализация**.
- необходимо реализовать какую-либу фичу под определенную для вашего проекта архитектуру - **пишем свою реализацию (или ищем какую-нибудь библиотечку) или думаем о дополнениях для уже выбранного framework'а**.
- существующие фреймворки не способены ответить некоторым вашим требованиям / задачам - **подумать, реализовать для выбранного фрэймворка плагин или всё таки написать свое решение**.
- необходимо реализовать функционал, который имеется как отдельная фича в различных фрэймворках - **посмотреть, возможно ли ею воспользоваться как модуль, впишется ли она в ваш проект и архитектуру**.
- пишем какой-то коммерческий код и лицензия framework'а не вписывается в вашу лицензию, или когда пишем проприетарный продукт - **пишем свою реализацию**.
- реализация фреймворка не покрыта тестами, код сомнителен, у фреймворка нет хорошего community и support, git не обновлялся 200 лет - **пишем свою реализацию**. 
- вы видите во всём новом абсолютный hype и вы code hipster - **юзаем все фреймворки, которые слышим на конференциях и пихаем их везде, до куда долезут руки**.

---