# Удалите текущий упрощённый скрипт
rm ~/.termux_scripts/скопировать_все

# Создайте ПОЛНУЮ версию (скопируйте ЭТОТ блок)
cat > ~/.termux_scripts/скопировать_все << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# МАССОВЫЙ КОПИРОВЩИК И РЕГИСТРАТОР КОМАНД
# Версия: 3.2 - ПОЛНАЯ РАБОЧАЯ ВЕРСИЯ
# ==============================================

# Цвета для вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo -e "${GREEN}   МАССОВОЕ КОПИРОВАНИЕ И РЕГИСТРАЦИЯ КОМАНД${NC}"
echo -e "${GREEN}            ПОЛНАЯ РАБОЧАЯ ВЕРСИЯ${NC}"
echo -e "${BLUE}══════════════════════════════════════════════${NC}\n"

# ===== ПУТИ =====
BASE_DIR="/storage/emulated/0/Documents/15_Настройки_скрипты_Termux_бекап_рестор/Алиасы_команды_SH"
BIN_DIR="$BASE_DIR/bin"
TERMUX_SCRIPTS="$HOME/.termux_scripts"
TERMUX_BIN="$HOME/bin"

echo -e "${YELLOW}📁 Поиск в папке:${NC} $BASE_DIR"
echo -e "${YELLOW}📁 Поиск в папке bin:${NC} $BIN_DIR\n"

# Создаём папки
mkdir -p "$TERMUX_SCRIPTS" "$TERMUX_BIN"
echo -e "${GREEN}✅ Папки созданы:${NC}"
echo "   $TERMUX_SCRIPTS"
echo "   $TERMUX_BIN\n"

# Проверка PATH
if ! echo "$PATH" | grep -q "$HOME/bin"; then
    echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc
    export PATH="$PATH:$HOME/bin"
    echo -e "${YELLOW}📝 PATH настроен\n${NC}"
fi

# Счётчики
TOTAL_FILES=0
COPIED_FILES=0
REGISTERED_FILES=0
WORKING_COMMANDS=()

# Функция регистрации команды
register_command() {
    local source_file="$1"
    local filename=$(basename "$source_file")
    
    if [[ "$filename" == *".sh" ]]; then
        echo -e "   ${YELLOW}⏭️ Пропускаю .sh файл: $filename${NC}"
        return 1
    fi
    
    TOTAL_FILES=$((TOTAL_FILES + 1))
    echo -e "${BLUE}[$TOTAL_FILES]${NC} Найден: $filename"
    
    # Копируем
    chmod +x "$source_file" 2>/dev/null
    cp "$source_file" "$TERMUX_SCRIPTS/$filename" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        COPIED_FILES=$((COPIED_FILES + 1))
        echo -e "   ${GREEN}✅ Скопировано${NC}"
        
        # Регистрируем
        chmod +x "$TERMUX_SCRIPTS/$filename"
        ln -sf "$TERMUX_SCRIPTS/$filename" "$TERMUX_BIN/$filename"
        
        REGISTERED_FILES=$((REGISTERED_FILES + 1))
        WORKING_COMMANDS+=("$filename")
        echo -e "   ${GREEN}✅ Зарегистрировано: $filename${NC}\n"
    else
        echo -e "   ${RED}❌ Ошибка копирования${NC}\n"
    fi
}

# Поиск в основной папке
if [ -d "$BASE_DIR" ]; then
    for file in "$BASE_DIR"/*; do
        if [ -f "$file" ]; then
            register_command "$file"
        fi
    done
else
    echo -e "${RED}❌ Папка не найдена: $BASE_DIR${NC}\n"
fi

# Поиск в папке bin
if [ -d "$BIN_DIR" ]; then
    for file in "$BIN_DIR"/*; do
        if [ -f "$file" ]; then
            register_command "$file"
        fi
    done
else
    echo -e "${RED}❌ Папка не найдена: $BIN_DIR${NC}\n"
fi

# Итоги
echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo -e "${GREEN}📊 СТАТИСТИКА${NC}"
echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo -e "📁 Найдено файлов: ${YELLOW}$TOTAL_FILES${NC}"
echo -e "📋 Скопировано: ${GREEN}$COPIED_FILES${NC}"
echo -e "🔧 Зарегистрировано: ${GREEN}$REGISTERED_FILES${NC}\n"

# Список рабочих команд
if [ ${#WORKING_COMMANDS[@]} -gt 0 ]; then
    echo -e "${GREEN}✅ РАБОЧИЕ КОМАНДЫ:${NC}"
    for cmd in "${WORKING_COMMANDS[@]}"; do
        echo -e "   • ${GREEN}$cmd${NC}"
    done
    echo ""
fi

# Проверка стандартных команд
echo -e "${YELLOW}🔍 ПРОВЕРКА:${NC}"
for cmd in генератор mdhtml мддок мдфб2 мдепуб; do
    if command -v "$cmd" &>/dev/null; then
        echo -e "   ${GREEN}✅ $cmd работает: $(which "$cmd")${NC}"
    else
        echo -e "   ${RED}❌ $cmd не работает${NC}"
    fi
done

echo -e "\n${BLUE}══════════════════════════════════════════════${NC}"
if [ $REGISTERED_FILES -gt 0 ]; then
    echo -e "${GREEN}🏁 ГОТОВО! Зарегистрировано команд: $REGISTERED_FILES${NC}"
else
    echo -e "${RED}🏁 НИ ОДНА КОМАНДА НЕ ЗАРЕГИСТРИРОВАНА${NC}"
fi
echo -e "${BLUE}══════════════════════════════════════════════${NC}"
EOF

# Дайте права
chmod +x ~/.termux_scripts/скопировать_все

# Запустите!
скопировать_все