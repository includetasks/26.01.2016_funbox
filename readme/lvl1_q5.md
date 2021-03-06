#### Q5. Какие инструменты для профайлинга и дебага вы используете? Какие у них минусы? Какие продукты вы использовали для профайлинга и дебага сетевых приложений?

---

О минусах пока не могу особо судить, т.к. не так много опыта в работе с таким инструментарием (не часто дебажу и профайлю). Скажу лишь о том, что я использовал:

***Профайлинг и дебаг***:

- **Benchmark** для определения, сколько времени потрачено на выполнение метода или программы в целом;
- **-r profile** для оценки работы моих методов по времени;
- **RubyMine IDE Debugger**: в RM очень удобный интерактивный дебаггер с классным инструментарием;
- **.inspect**: быстро проверить, что хранит какой-либо объект;
- **byebug** - только пробовал, когда смотрел, как пользоваться этим дебаггером, хороший полноценный консольный дебаггер.

***Особо не пользовался, но воспользовался бы в будущем***:

- **ruby-prof** - особо не пользовался, но очень хоорошая тулза для профайлинга как замена стандартному -r profile;
- **gem [gc_tracer](https://github.com/ko1/gc_tracer)** - для подхвата событий GC и трассировки его вызовов;
- **множество nix-tools** (например, простой мониторинг памяти процессов или просмотр системных вызовов во время выполнения вашей программы).
  
Для профайлинга утечек памяти воспользовался бы следующими ruby-гемами и методами некоторых библиотек: GC::Profiler, gc_tracer, ObjectSpace, GC.start / GC.stat. Конечно, есть еще полноценные тулкиты для профилирования процессов и памяти, но я пока не занимался их изучением.

***Сетевые приложения***:

- **Wireshark**: когда-то давно смотрел на то, какие запросы и ответы генерируют приложения на низком уровне. Воспользовался бы для дебага сетевого приложения;
- **nmap**: проверить работу своего сервиса извне, хотя этот инструмент способен на большее;
- **curl**: собрать кастомный сетевой запрос;
- **Advanced REST Client (Chrome Extention)**: удобно работать с REST API и тестировать его;
- **MailCatcher**: легкий SMTP-сервер с вэб-интерфейсом, удобно быстро обрабатывать и просматривтаь письма, генерируемые приложением во время разработки
- Для Security-тестов можно воспользоваться **Burp Suite** и **Metasploit** (пробовал только **Metasploit**).
