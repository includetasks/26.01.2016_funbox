#### Q5. Напишите скрипт grab.rb принимающий на вход 2 параметра, например так: ./grab.rb 'www.google.com' /tmp

- Скрипт должен скачать все картинки, содержащиеся на странице, указанной первым параметром, в папку, указанную вторым параметром;
- Скрипт может использовать модули, находящиеся в той же папке, что и сам скрипт;
- Дополнительные условия: скрипт должен максимально загрузить доступный канал и отрабатывать как можно быстрее. 

---

Алгоритм работы скрипта прост:

1. взять параметры из консоли;
2. создать папку, куда будут сохраняться файлы, если её нет;
3. спарсить все изображения и ссылки на них;
4. отбросить битые ссылки и ссылки с mime-типами, не соответствующие изображениям;
5. скачать изображения по оставшимся ссылкам.

Для работы скрипта из консоли я добавил возможность передачи ему параметров:

- **-u (--uri) uri** - ссылка на страницу, откуда нужно сграббить изображения;
- **-o (--output-dir) output_dir** - папка, куда будут сохраняться скачанные изображения.

Пример работы со скриптом: **./grubber.rb -u coffeescript.org -o ./tmp**.

Реализация состоит из 2-х модулей и 2-х классов:

- **Grubbers** - основной модуль, который хранит набор модулей, реализующих грабберы;
- **Grubbers::ImageGrubber** - модуль граббера, скачивающего изображения с целевого ресурса;
- **Grubbers::ImageGrubber::Grubber** - класс, реализующий ImageGrubber;
- **Grubbers::ImageGrubber::ConsoleTool** - класс, реализующий парсер параметров, переданных через консоль (основан на использовании OptParse).

Для работы с **ImageGrubber::Grubber**, необходимо инициализировать его, передав ему целевой ресурс и output-директорию как стороковые парамтеры, а затем вызвать метод .grub.
Для вывода в консоль процесса скачивания, в метод .grub необходимо передать false (по умолчанию, verbose = true).

**Пример работы:**

```bash
daiver@vaio ~/P/R/funbox>./scripts/grubber.rb -u http://www.advantika.ru/ -o ./tmp
DOWNLOADED: http://www.advantika.ru:80/bitrix/templates/.default/images/logo.png
DOWNLOADED: http://www.advantika.ru:80/upload/iblock/031/031f798efb6283b521734a16ce83fd9c.png
...много файлов...
DOWNLOADED: http://www.advantika.ru:80/upload/iblock/0ba/0bab74ff89b8224fe9462d691f1c1a35.png
```

**Реализация**:
 
- имплементация: [GitLink](https://github.com/includetasks/include_tasks/tree/master/lib)
    - [Grubbers](https://github.com/includetasks/include_tasks/blob/master/lib/grubbers.rb)
    - [ConsoleTool](https://github.com/includetasks/include_tasks/blob/master/lib/grubbers/image_grubber/console_tool.rb)
    - [ImageGrubber](https://github.com/includetasks/include_tasks/blob/master/lib/grubbers/image_grubber/grubber.rb)
- пример использования: [GitLink](https://github.com/includetasks/include_tasks/blob/master/scripts/grubber.rb)

---