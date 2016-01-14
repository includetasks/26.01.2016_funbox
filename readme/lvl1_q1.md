Все вопросы по отдельности:

- LEVEL 1
  - [Q1: Какие сторонние библиотеки вы используете чаще всего для разработки. Какие плюсы в них вы выделяете для себя?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl1_q1.md)
  - [Q2. При работе в команде, каким бы местам в разработке вы бы уделили большее внимание? Какие бы соглашения (Coding Conventions) вам бы помогли в командной разработке?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl1_q2.md)
  - [Q3. Вы когда-нибудь писали в функциональном стиле на Ruby? Если да, то какие сильные и слабые стороны есть у данного подхода?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl1_q3.md)
  - [Q4. Расскажите об используемых Вами фреймворках (программных каркасах). В чем их плюсы? Для каких задач лучше использовать существующий фреймворк, а когда лучше все написать самому?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl1_q4.md)
  - [Q5. Какие инструменты для профайлинга и дебага вы используете? Какие у них минусы? Какие продукты вы использовали для профайлинга и дебага сетевых приложений?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl1_q5.md)
  - [Q6. Какие плюсы и минусы есть у системы обработок ошибок в Ruby?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl1_q6.md)
  - [Q7. На каких языках программирования вы дополнительно пишите код?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl1_q7.md)
- LEVEL 2
  - [Q1. Объясните почему происходит следующее](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl2_q1.md)
  - [Q2. Нужно написать прослойку между почтовым сервером и front-end приложением (Flash AS3 Application). Опишите следующие моменты:](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl2_q2.md)
  - [Q3. Объясните в чем разница в использовании тредов (threads) и форков (forks). В каких случаях, какой вариант более предпочтительный для использования? Как можно профилировать и проводить дебаг приложений с использованием тредов?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl2_q3.md)
  - [Q4. Расскажите как можно организовать работу кода в Ruby в асинхронном режиме?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl2_q4.md)
  - [Q5. Напишите скрипт grab.rb принимающий на вход 2 параметра, например так: ./grab.rb 'www.google.com' /tmp](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl2_q5.md)
  - [Q6. Покройте код предыдущей задачи тестами (плюсом будет использование rspec).](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl2_q6.md)
- LEVEL 3
  - [Q1. У вас есть массив целых чисел. Все числа идут последовательно от 1 до k. Но в массиве пропущены 2 числа. Реализуйте алгоритм для нахождения этих чисел.](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl3_q1.md)
  - [Q2. Какие нюансы в работе виртуальной машины Ruby вы знаете? Какие оптимизации над кодом можно произвести для ускорения его выполнения?](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl3_q2.md)
  - [Q3. Привести пример максимально быстрого алгоритма](https://github.com/tasksfromfb/tffb/blob/master/readme/lvl3_q3.md)


### LEVEL 1

---

#### Q1: Какие сторонние библиотеки вы используете чаще всего для разработки. Какие плюсы в них вы выделяете для себя?

---

Примечание: по большей части, сейчас будет идти выжимка из Gemfile'ов с некоторыми комментариями; большинство из всех гемов - rails oriented (за исключением секции in the wild), т.к. в основном писал под Rails.
В своем обучении (тобишь что изучаю до сих пор) и в повседневной разработке пользуюсь следующим набором библиотек и фреймворков (некоторыми пользовался лишь однажды, некоторыми пользуюсь постоянно):

###### Wild Libs
- [Nokogiri](nokogiri) - парсинг web-страниц;
- [Ruby ProgressBar](ruby-progressbar) - прогресс-бар для консольных приложений;
- [Addressable](addressable) - решение проблем стандартной либы URI (URI::Generic'и сломали мне голову, когда я использовал URI вместе с open-uri, умеет эвристически собирать url'ки на базе неполных данных (нет порта, нет схемы и т.п.));
- [open-uri-redirecions](open_uri_redirections) - поддержка автоматических редиректов http <=> https;
- [EventMachine](https://github.com/eventmachine/eventmachine),[em-websockets](https://github.com/igrigorik/em-websocket) - писал очень простой пример приложение-чата на вэбсокетах. Под капотом крутились эти гемы для имплементации простенького вэбсокет-сервиса.
- [Benchmark](http://ruby-doc.org/stdlib-1.9.3/libdoc/benchmark/rdoc/Benchmark.html) - определение времени выполнения блока кода. Удобно, когда нужно проследить, сколько времени выполняется часть вашего кода, что может помочь в оптимизации кода, или намекнуть, что пора бы здесь что-то порефакторить.
- [ruby-prof](https://github.com/ruby-prof/ruby-prof) - только пробовал, очень интересный профилировщик, помощнее стандартного -r profile. Воспользовался бы в будущем.

###### Frameworks

- [Ruby on Rails](https://github.com/rails/rails) - мэйнстрим в Ruby-тусовке среди Web-разработчиков. All-in Web-Framework;
- [Sinatra](https://github.com/sinatra/sinatra) - легковесный micro-web-framework, который очень удобен для написания RESTful API. Естественно, способен на большее. Я его позиционирую как нечто вроде ExpressJS из мира NodeJS, или (идеологически) как BackboneJS для создания собственных web-framework'ов (и не только). Иногда пользуюсь, когда нужно что-то быстренько запрототипить;

###### Testing tools, libraries and frameworks

- [RSpec](http://rspec.info/) - стандарт де-факто в тестировании приложений, написанных на Ruby;
- [JSON Schema Validator](https://github.com/ruby-json-schema/json-schema) - встала проблема (или идея) как тестировать JSON-ответы на их структуру. Чувствовал, есть DRY-способы, и более продвинутые, чем простое .to_s и .include?. В поисках решения нашел вот такую интересную библиотеку, которую можно интегрировать в тесты, написав кастомный матчер. Очень удобная вещь и, я бы даже сказал, must have;
- [Factory Girl](https://github.com/thoughtbot/factory_girl) - генерация данных для тестов. Must have. Использую как замена стандартным RoR-фикстурам;
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) - юзаю для управления поведением транзакций и очистки базы данных в тестах Ruby on Rails приложений;
- [MiniTest](https://github.com/seattlerb/minitest) - хороший фрэймворк для тестирования приложений на Ruby. Встроен в Ruby, использовал при первом знакомстве с Ruby on Rails;
- [Capybara](https://github.com/jnicklas/capybara) - integration-тесты для ваших web-приложений. Must-have (selenium-webdriver берем под мышку :))
- [Minitest reporters](https://github.com/kern/minitest-reporters) - библиотечка-расширение для MiniTest. Когда-то использовал при тестировании Rails-приложений. Удобно минифаит и бьютифаит console output.

###### Automation toolkits

- [Rubocop](https://github.com/bbatsov/rubocop) - статический анализатор кода. Использую для слежки за очевидными ошибками в форматировании кода, а так же он работает как мой 'CodeStyle-полицейский';
- [Guard](https://github.com/guard/guard) - тулкит для автоматизации задач. Пробовал использовать для автоматического запуска тестов и syntax checking'а различных языков. Отказался от использования именно в этом направлении, т.к. считаю, что синтаксис должны проверять IDE/TextEditor, а запуск тестов я запускаю ручками сам, т.к. когда тестов много, или когда вы очень часто сэйвите файл (как я), Guard доставит вам много Overhead-хлопот (в бонус к радостям жизни).

###### Libraries

- [Faker](https://github.com/stympy/faker) - генератор случайных данных (names, dates, emails, texts, etc.). Использую, когда надо наполнить данными web-приложения для имитации их работы in the wild;

###### Rails based libraries

- [Devise](https://github.com/plataformatec/devise) - организации функционала аутентификации пользователей на сайте. Must have;
- [Devise-Token-Auth](https://github.com/lynndylanhurley/devise_token_auth) - реализация гема Devise для Rails JSON API based приложений. Must have;
- [Meta Request](https://github.com/dejan/rails_panel/tree/master/meta_request) - debug-библиотека для Rails-приложений, которая работает в паре с соответствующим [Rails Panel](https://github.com/dejan/rails_panel)-CrhomeExtention. Юзаю для дебага RoR-приложений (смотрим, какой контроллер отвечает, какие данные пробрасываюстя, какие модели хватаются, сколько по времени всё занимает, etc.);
- [Responders](https://github.com/plataformatec/responders) - набор respond-методов для контроллеров. Пробовал использовать, чтобы по-DRY-ить код, свернув конструкцию respond_to=>format=>render до глобального respond_to и сахарного respond_with, но мне очень нужен был Control flow в respond_to, поэтому пока не использую;
- [Stronger Parameters](https://github.com/zendesk/stronger_parameters) - type checking и type casting в permit-методах контроллеров. Когда встала в этой либке? Ситуация следующая: есть модель, у неё есть поле, которое представляет собой некое состояние и базируется на множестве Integer-значений, представляя собой ActiveRecord enum-поле (чтобы можно было осмысленно отразить каждое значение на некое текстовой поле). Мне нужен был автоматический каст (DRY DRY DRY :)) этих значений из текстового представления от frontend'а в integer-представление моей модели. Очень удобно.
- [Rails ERD](https://github.com/voormedia/rails-erd) - генератор Entity Relationship Diagrams на основе моделей ActiveRecord. Когда моделей в проекте становится очень много, а связей между ними - несусветное множество, этот гем позволяет визуализировать ваши связи в отдельный файл (хотя, там тоже будет нехилый такой бардачок, но анализировать его на каком-нибудь экране проектора очень удобно);
- [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) - хэндлер загрузки файлов для Web-фреймворков;
- [Browserify-Rails](https://github.com/browserify-rails/browserify-rails) - использовал однажды, когда пробовал подключить интересный ReactJS-фреймворк [Material-UI](https://github.com/callemall/material-ui) напрямую к рельсам из npm. Не Rails-Way, не использую больше;
- [MiniMagick](https://github.com/minimagick/minimagick) - обработка изображений, wrapper для ImageMagick/GraphicsMagick.
- [Better Errors](https://github.com/charliesome/better_errors) - замена стандартной страницы ошибки на более информативную (интересная фича: вывод части кода файла с подсветкой строки, где произошла ошибка)

###### Frontend frameworks integration for Rails

- Примечание: возможно, стоит отказаться от сборки ассэтов через Asset Pipeline и отдать эту прерогативу Webpack'у, т.к. в этом плане он намного круче и мощнее;
- [Haml](https://github.com/indirect/haml-rails) - интеграция шаблонизатора Haml в RoR. больше не использую из-за невозможности инлайнить многие вещи в простой текст (особенно раздражают сумасшедшие лестницы из текст-тэг-текст, когда необходимо заинлайнить html в текст). В свящи с этим перешел на Slim;
- [Slim](https://github.com/slim-template/slim-rails) - интеграция шаблонизатора Slim в RoR. Решил проблемы Haml'а. Понравился бонус из подмешиваемого HTML в Slim-файл. Если надо что-то потестить быстро (какой-нибудь банальный ctrl-c ctrl-v сырого html-кода) - эта фича спасает);
- [Material Design Lite](http://www.getmdl.io/) - интеграция frontend-фрэймворка Material Design Lite;
- [Material Design Icons](https://github.com/Angelmmiguel/material_icons) - material design style icons;
- [Twitter Bootstrap](bootstrap-sass) - интегрируем Frontend TwitterBootstrap Framework в RoR;
- [FontAwesome](font-awesome-sass) - интеграция иконок FontAwesome в проекты на RoR;
- [will_paginate](will_paginate) - пагинация для коллекций ActiveRecord моделей;
- [Authoprefixer](autoprefixer-rails) - спасает жизнь от горы vendor-css-миксинов в SASS, интегрится в Rails Assets Pipeline;
- [Fluxxor](http://fluxxor.com/) - интеграция JS-библиотеки Fluxxor в RoR-проекты (сейчас изучаю Flux-методологию во frontend-разработке, пригляделась эта библиотечка, реализующая эту методологию);
- [ReactJS](https://facebook.github.io/react/) - интеграция JS-библиотеки React в RoR-проекты (начал изучать ReactJS, понадобилась интеграция в RoR. интересна, наверно, по большей части своими возможностями рендеринга на backend'e);
- [ReactRouter](https://github.com/rackt/react-router) - интеграция JS-библиотеки ReactRouter в RoR-проекты (интересовало, как реализовать роутинг на ReactJS, приглянулась эта либка, пока не пробовал еще, но оставил себе на заметку)

---