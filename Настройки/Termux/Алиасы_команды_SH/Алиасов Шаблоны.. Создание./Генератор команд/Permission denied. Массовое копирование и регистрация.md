



## 🚀 Если хотите сделать это для всех скриптов разом:

```bash
# Массовое копирование и регистрация
for script in /storage/emulated/0/Documents/15_Настройки_скрипты_Termux_бекап_рестор/Алиасы_команды_SH/*.sh; do
    name=$(basename "$script" .sh)
    cp "$script" ~/.termux_scripts/
    chmod +x ~/.termux_scripts/"$name".sh
    ln -sf ~/.termux_scripts/"$name".sh ~/bin/"$name"
    chmod +x ~/bin/"$name"
    echo "✅ $name"
done
```




