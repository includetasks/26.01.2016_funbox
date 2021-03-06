#### Q3. Объясните в чем разница в использовании тредов (threads) и форков (forks). В каких случаях, какой вариант более предпочтительный для использования? Как можно профилировать и проводить дебаг приложений с использованием тредов?

---

Форк - это процесс, запущенный как дочерний текущему процессу. Некое подобие ветвления выполнения программы.

- выполняется в собственном адресном пространстве.
- начальное состояние дочерний процесс копирует у родительского процесса на момент своей инициализации.
- не имеет доступа к состоянию родительского процесса: для этого придется подумать о системе коммуникаций между процессами (например, подхватить stdin/stdout/stderr дочернего процесса из родительского).
- Форк имеет природу процесса, а, значит, в конце своей работы возвращает только код завершения, который, согласно UNIX-соглашению, равен 0, если процесс завершился успешно, и любое отличное от нуля значение, когда процесс завершился с ошибкой. 
- В Ruby форки возвращают pid, а модуль Process может вернуть pid и статус завершения. В Ruby мы можем завершать процесс методоам kill/exit (всё присущее ruby-программам) или приостанавливать работу процесса методом sleep.
- Дождаться завершения процесса можем с помощью метода модуля Process: Process.wait.

Тред (поток) - блок кода, выполняемый в конексте текущего процесса "асинхронно". Имеет общее состояние между всеми потоками в рамках процесса, в котором они запущены, и, следовательно, коммуникацию между потоками проще организовывать.

- Треды, в отличие от форков, по своему заверщению способны возвратить состояние. 
- В Ruby имеется возможность обращаться к значениям объекта треда в стиле хэша (если тред установил эти значения), или получить выходное значениее методом Thread.value. 
- В Ruby мы можем управлять ходом выполнения потоков методами stop/sleep/wakeup/run/raise/exit/join.

В каких случаях какой вариант более предпочтительней?

- Треды удобны для распараллеливания некого куска кода для ускорения работы метода в целом, когда имеется возможность выполнять некоторые шаги алгоритма независимо от выполнения последующих шагов, или когда часть алгоритма выполняется в цикле, и процесс в таком случае можно распараллелить, если каждый шаг цикла атомарен по отношению к следующему.
- Форки удобно использовать, когда нам нужно запустить какой-то скрипт как отдельном процесс, и когда мы именно этого хотим. Процесс будет диспетчиться системой, а значит, у процесса все характеристики реальных процессов, обрабатываемых системой (по своему выделяется память, по своему диспетчится диспетчером процессов, etc). Также, возможно удобно в интеграционных тестах (воспользовался таким подходом, когда тетсировал программу из следующих вопросов).

Я не дебажил приложения, написанных с использованием потоков, но знаю, что можно воспользоваться гемом byebug, который позволяет дебажить потоки, а также встроенный дебаггер RubyMINE тоже позволяет работать с потоками.

---