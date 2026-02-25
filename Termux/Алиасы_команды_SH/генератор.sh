

# ==============================================
# ГЕНЕРАТОР НОВЫХ КОМАНД (только слово "генератор")
# ==============================================
# Версия: 3.2 - ИСПРАВЛЕННАЯ
# ==============================================

# Цвета для вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}==============================================${NC}"
echo -e "${GREEN}   ГЕНЕРАТОР НОВЫХ КОМАНД (ПОЛНЫЙ АВТОМАТ)${NC}"
echo -e "${BLUE}==============================================${NC}"
echo ""

echo -e "${YELLOW}📋 ЗАПОЛНИТЕ ОБЩУЮ ИНФОРМАЦИЮ:${NC}"
echo ""

read -p "📅 Дата создания (Enter для 2026.02.22): " user_date
user_date=${user_date:-2026.02.22}

read -p "✍️ Автор (Enter для Рафаэль): " user_author
user_author=${user_author:-Рафаэль}

read -p "📝 Краткое описание: " user_description
user_description=${user_description:-"Конвертирует файлы"}

echo ""
echo -e "${YELLOW}⚙️ ПАРАМЕТРЫ КОНВЕРТАЦИИ:${NC}"
echo ""

read -p "📄 Исходный формат (md, txt, csv и т.д.): " input_format
input_format=${input_format:-md}

read -p "🎯 Целевой формат (html, docx, pdf, epub, fb2 и т.д.): " output_format
output_format=${output_format:-html}

read -p "🔤 Название команды (только буквы): " alias_name
alias_name=${alias_name:-мдгтмл}

read -p "📁 Дополнительная папка в Documents: " user_folder
user_folder=${user_folder:-"03_md_${output_format}_${alias_name}"}

# Формируем пути
work_dir="/storage/emulated/0/Documents/${user_folder}"
work_dir=$(echo "$work_dir" | sed 's|//|/|g')

scripts_dir="/storage/emulated/0/Documents/15_Настройки_скрипты_Termux_бекап_рестор/Алиасы_команды_SH"
output_file="$scripts_dir/$alias_name"

echo ""
echo -e "${BLUE}==============================================${NC}"
echo -e "${GREEN}🔧 Генерация скрипта...${NC}"
echo -e "${BLUE}==============================================${NC}"
echo ""

# Создаём папку для скриптов, если её нет
mkdir -p "$scripts_dir"

# -------------------- СОЗДАНИЕ ФАЙЛА --------------------
cat > "$output_file" << 'INNER_SCRIPT'














#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# __ALIAS__ - Конвертер __INPUT__ → __OUTPUT__
# ==============================================
# Дата создания: __DATE__
# Автор: __AUTHOR__
# Описание: __DESCRIPTION__
# ==============================================

WORK_DIR="__WORKDIR__"
INPUT_EXT="__INPUT__"
OUTPUT_EXT="__OUTPUT__"
FOLDER_SUFFIX=" - __OUTPUT__"

echo "=============================================="
echo "     __ALIAS__ - Конвертер __INPUT__ → __OUTPUT__"
echo "=============================================="
echo "📁 Рабочая папка: $WORK_DIR"
echo ""

if ! command -v pandoc &> /dev/null; then
    echo "📦 Устанавливаю pandoc..."
    pkg install -y pandoc
fi

mkdir -p "$WORK_DIR"

FILES_FOUND=0
FILES_CONVERTED=0

echo "🔍 Поиск файлов .$INPUT_EXT..."
echo ""

# Исправленная логика поиска и конвертации
find "$WORK_DIR" -type f -name "*.$INPUT_EXT" 2>/dev/null | while read full_path; do
    
    FILES_FOUND=$((FILES_FOUND + 1))
    filename=$(basename "$full_path" .$INPUT_EXT)
    filedir=$(dirname "$full_path")
    
    echo "📄 [$FILES_FOUND] $filename.$INPUT_EXT"
    
    # ========== ИСПРАВЛЕННАЯ ЛОГИКА СОЗДАНИЯ ПАПОК ==========
    
    # Получаем имя папки, в которой лежит файл
    parent_folder=$(basename "$filedir")
    
    # Формируем новую папку: "имя_родительской_папки - fb2"
    new_folder_name="${parent_folder}${FOLDER_SUFFIX}"
    
    # Создаём новую папку на том же уровне, что и исходная
    new_folder_path="$(dirname "$filedir")/$new_folder_name"
    
    mkdir -p "$new_folder_path"
    echo "   └─ Новая папка: $new_folder_name"
    
    # Конвертируем файл прямо в новую папку
    output_file="$new_folder_path/$filename.$OUTPUT_EXT"
    
    # ========== КОНЕЦ ИСПРАВЛЕНИЙ ==========
    
    pandoc "$full_path" -o "$output_file"
    
    if [ $? -eq 0 ]; then
        chmod 644 "$output_file"
        echo "      ✅ Готово: $filename.$OUTPUT_EXT"
        FILES_CONVERTED=$((FILES_CONVERTED + 1))
    else
        echo "      ❌ Ошибка"
    fi
done

echo ""
echo "=============================================="
echo "✅ КОНВЕРТАЦИЯ ЗАВЕРШЕНА"
echo "📊 Найдено: $FILES_FOUND, Сконвертировано: $FILES_CONVERTED"
echo "=============================================="














INNER_SCRIPT

# Заменяем плейсхолдеры на реальные значения
sed -i "s|__ALIAS__|$alias_name|g" "$output_file"
sed -i "s|__INPUT__|$input_format|g" "$output_file"
sed -i "s|__OUTPUT__|$output_format|g" "$output_file"
sed -i "s|__DATE__|$user_date|g" "$output_file"
sed -i "s|__AUTHOR__|$user_author|g" "$output_file"
sed -i "s|__DESCRIPTION__|$user_description|g" "$output_file"
sed -i "s|__WORKDIR__|$work_dir|g" "$output_file"

# -------------------- ДАЕМ ПРАВА --------------------
chmod +x "$output_file"
echo -e "${GREEN}✅ Скрипт создан: $output_file${NC}"
echo ""

# -------------------- КОПИРУЕМ В .termux_scripts --------------------
echo -e "${YELLOW}📦 Копирую в ~/.termux_scripts/...${NC}"
mkdir -p ~/.termux_scripts
cp "$output_file" ~/.termux_scripts/
chmod +x ~/.termux_scripts/"$alias_name"
echo -e "${GREEN}✅ Скопировано в: ~/.termux_scripts/$alias_name${NC}"
echo ""

# -------------------- АВТОМАТИЧЕСКАЯ РЕГИСТРАЦИЯ --------------------
echo -e "${YELLOW}⚙️ АВТОМАТИЧЕСКАЯ РЕГИСТРАЦИЯ КОМАНДЫ...${NC}"
echo ""

unalias "$alias_name" 2>/dev/null
sed -i "/$alias_name/d" ~/.bashrc
rm -f ~/bin/"$alias_name" 2>/dev/null

mkdir -p ~/bin
ln -sf ~/.termux_scripts/"$alias_name" ~/bin/"$alias_name"
chmod +x ~/bin/"$alias_name"

if ! echo "$PATH" | grep -q "$HOME/bin"; then
    echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc
fi

echo "alias $alias_name='~/.termux_scripts/$alias_name'" >> ~/.bashrc
source ~/.bashrc

echo -e "${GREEN}✅ Команда '$alias_name' зарегистрирована${NC}"
echo ""

# -------------------- ПРОВЕРКА --------------------
echo -e "${YELLOW}🔍 ПРОВЕРКА:${NC}"
echo ""

which_output=$(which "$alias_name" 2>/dev/null)
if [ -n "$which_output" ]; then
    echo -e "${GREEN}✅ which $alias_name → $which_output${NC}"
else
    echo -e "${RED}❌ which $alias_name → НЕ НАЙДЕНА${NC}"
fi

alias_output=$(alias | grep "$alias_name" 2>/dev/null)
if [ -n "$alias_output" ]; then
    echo -e "${GREEN}✅ alias $alias_name → $alias_output${NC}"
else
    echo -e "${RED}❌ alias $alias_name → НЕ НАЙДЕН${NC}"
fi

if [ -f ~/bin/"$alias_name" ]; then
    echo -e "${GREEN}✅ Файл в ~/bin/ существует${NC}"
else
    echo -e "${RED}❌ Файл в ~/bin/ отсутствует${NC}"
fi

echo ""
echo -e "${BLUE}==============================================${NC}"
echo -e "${GREEN}🏁 ВСЁ ГОТОВО! Команда '$alias_name' создана и зарегистрирована.${NC}"
echo -e "${BLUE}==============================================${NC}"
echo ""
echo -e "${YELLOW}📁 Рабочая папка:${NC} $work_dir"
echo -e "${YELLOW}🔤 Команда для запуска:${NC} $alias_name"
echo ""
echo -e "${GREEN}Пример:${NC}"
echo "   $alias_name"
echo ""
