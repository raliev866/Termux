


# ПРОВЕРКА РАБОТОСПОСОБНОСТИ**

## **6.1 Проверка всех созданных команд**


### Список всех команд

```bash
# Список всех команд
ls -la ~/bin/
# мдепуб@ -> ~/.termux_scripts/мдепуб.sh
# мддок@ -> ~/.termux_scripts/мддок.sh
# мдхтмл@ -> ~/.termux_scripts/мдхтмл.sh
# генератор@ -> ~/.termux_scripts/генератор.sh
```


### Проверка PATH

```bash
# Проверка PATH
echo $PATH | grep "$HOME/bin"
# Должен содержать /data/data/com.termux/files/home/bin
```


### Проверка каждой команды

```bash
# Проверка каждой команды
for cmd in ~/bin/*; do
    echo -n "$(basename $cmd): "
    which $(basename $cmd)
done
```

## **6.2 Проверка после перезагрузки Termux**

### Закрыть и открыть Termux

```bash
# Закрыть и открыть Termux
мдепуб test.md  # Должно работать сразу
```

---

