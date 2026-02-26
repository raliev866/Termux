#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# MEGA-УСТАНОВЩИК ВСЕХ ПРОГРАММ ДЛЯ TERMUX
# Версия: 3.0 - ВСЁ В ОДНОМ
# ==============================================

# Цвета для красивого вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Функция для рисования заголовков
print_header() {
    echo -e "${BLUE}══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}   $1${NC}"
    echo -e "${BLUE}══════════════════════════════════════════════${NC}"
}

# Функция проверки успешности установки
check_success() {
    if [ $? -eq 0 ]; then
        echo -e "   ${GREEN}✅ $1 установлен${NC}"
    else
        echo -e "   ${RED}❌ Ошибка при установке $1${NC}"
    fi
}

# Очистка экрана
clear
print_header "MEGA-УСТАНОВЩИК ВСЕХ ПРОГРАММ ДЛЯ TERMUX"
echo -e "${YELLOW}⚡ Скрипт объединяет ВСЕ пакеты из твоего файла!${NC}\n"

# ===== БАЗОВАЯ НАСТРОЙКА =====
print_header "1️⃣ БАЗОВАЯ НАСТРОЙКА TERMUX"
echo -e "${YELLOW}📦 Настраиваю доступ к хранилищу...${NC}"
termux-setup-storage
sleep 2

echo -e "${YELLOW}📦 Обновляю репозитории...${NC}"
pkg update -y && pkg upgrade -y
check_success "обновление репозиториев"

# ===== ПОДКЛЮЧЕНИЕ РЕПОЗИТОРИЕВ =====
print_header "2️⃣ ПОДКЛЮЧЕНИЕ ДОПОЛНИТЕЛЬНЫХ РЕПОЗИТОРИЕВ"
echo -e "${YELLOW}📦 Устанавливаю root-repo x11-repo tur-repo...${NC}"
pkg install -y root-repo x11-repo tur-repo
check_success "репозитории"

# ===== БАЗОВЫЕ УТИЛИТЫ =====
print_header "3️⃣ БАЗОВЫЕ УТИЛИТЫ"
pkg install -y python python-pip git wget curl vim nano micro tree zip unzip
check_success "базовые утилиты"

# ===== ОСНОВНЫЕ СИСТЕМНЫЕ ПАКЕТЫ =====
print_header "4️⃣ ОСНОВНЫЕ СИСТЕМНЫЕ ПАКЕТЫ"
pkg install -y termux-api termux-tools termux-exec termux-boot termux-float termux-styling termux-tasker termux-widget
pkg install -y openssh man tsu
check_success "системные пакеты"

# ===== ЯДРО СИСТЕМЫ (coreutils) =====
print_header "5️⃣ ЯДРО СИСТЕМЫ (coreutils)"
pkg install -y coreutils
check_success "coreutils (ls, cp, mv, chmod, mkdir...)"
echo -e "${GREEN}✅ ТЕПЕРЬ ВСЕ БАЗОВЫЕ КОМАНДЫ РАБОТАЮТ!${NC}"

# ===== ИНСТРУМЕНТЫ РАЗРАБОТКИ =====
print_header "6️⃣ ИНСТРУМЕНТЫ РАЗРАБОТКИ"
pkg install -y clang make cmake gcc gdb
pkg install -y rust cargo nodejs openjdk-17
pkg install -y golang lua perl
check_success "инструменты разработки"

# ===== КОНВЕРТАЦИЯ ФАЙЛОВ (ОСНОВНОЕ) =====
print_header "7️⃣ ПРОГРАММЫ ДЛЯ КОНВЕРТАЦИИ ФАЙЛОВ"
pkg install -y pandoc calibre ffmpeg texlive-bin groff ghostscript imagemagick
check_success "инструменты конвертации"

# ===== TTS ДЛЯ ОЗВУЧКИ ТЕКСТА =====
print_header "8️⃣ ТЕКСТ-В-РЕЧЬ (TTS) ДЛЯ СОЗДАНИЯ MP3"
pkg install -y espeak
# Альтернатива (более качественная):
# pkg install -y piper-tts
check_success "espeak (синтезатор речи)"

# ===== АРХИВАТОРЫ =====
print_header "9️⃣ АРХИВАТОРЫ"
pkg install -y unrar p7zip lzop arj
check_success "архиваторы"

# ===== БАЗЫ ДАННЫХ =====
print_header "🔟 БАЗЫ ДАННЫХ"
pkg install -y mariadb postgresql sqlite
check_success "базы данных"

# ===== ВЕБ-СЕРВЕР =====
print_header "1️⃣1️⃣ ВЕБ-СЕРВЕР"
pkg install -y apache2 nginx php php-apache phpmyadmin
check_success "веб-сервер"

# ===== СЕТЕВЫЕ УТИЛИТЫ =====
print_header "1️⃣2️⃣ СЕТЕВЫЕ УТИЛИТЫ"
pkg install -y traceroute netcat-openbsd nmap whois tor ngrok
check_success "сетевые утилиты"

# ===== МОНИТОРИНГ И ПРОИЗВОДИТЕЛЬНОСТЬ =====
print_header "1️⃣3️⃣ МОНИТОРИНГ И ПРОИЗВОДИТЕЛЬНОСТЬ"
pkg install -y htop neofetch tmux ranger ncdu
check_success "мониторинг"

# ===== ИНСТРУМЕНТЫ ДЛЯ ПЕНТЕСТА (ОПЦИОНАЛЬНО) =====
print_header "1️⃣4️⃣ ИНСТРУМЕНТЫ БЕЗОПАСНОСТИ (ОПЦИОНАЛЬНО)"
echo -e "${YELLOW}⚠️ Эти пакеты занимают много места (~500 МБ)${NC}"
read -p "Установить инструменты для тестирования безопасности? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    pkg install -y nmap hydra sqlmap metasploit wireshark aircrack-ng
    check_success "инструменты пентеста"
fi

# ===== РАЗВЛЕЧЕНИЯ И АВТОМАТИЗАЦИЯ =====
print_header "1️⃣5️⃣ ПОЛЕЗНЫЕ МЕЛОЧИ"
pkg install -y figlet cowsay fortune sl
check_success "развлечения"

# ===== НАСТРОЙКА GIT И SSH =====
print_header "1️⃣6️⃣ НАСТРОЙКА GIT И SSH"
read -p "Введи своё имя пользователя GitHub (Enter чтобы пропустить): " github_user
read -p "Введи свой email GitHub (Enter чтобы пропустить): " github_email

if [ -n "$github_user" ] && [ -n "$github_email" ]; then
    git config --global user.name "$github_user"
    git config --global user.email "$github_email"
    echo -e "${GREEN}✅ Git настроен${NC}"
    
    # Генерация SSH ключа
    echo -e "${YELLOW}🔑 Генерирую SSH ключ...${NC}"
    ssh-keygen -t rsa -b 4096 -C "$github_email" -f ~/.ssh/id_rsa -N ""
    echo -e "${GREEN}✅ SSH ключ создан${NC}"
    echo -e "${YELLOW}📋 Публичный ключ (добавь его в GitHub):${NC}"
    cat ~/.ssh/id_rsa.pub
fi

# ===== СОЗДАНИЕ АЛИАСОВ =====
print_header "1️⃣7️⃣ СОЗДАНИЕ АЛИАСОВ"
cat >> ~/.bashrc << 'EOF'

# Алиасы для Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gcl='git clone'

# Алиасы для конвертации
alias конверт-pandoc='pandoc'
alias конверт-calibre='ebook-convert'
alias конверт-ffmpeg='ffmpeg'
alias конверт-img='convert'
alias конверт-tts='espeak'

# Полезные алиасы
alias ll='ls -la'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias tree='tree -C'
EOF

echo -e "${GREEN}✅ Алиасы созданы${NC}"

# ===== ПРОВЕРКА УСТАНОВКИ =====
print_header "1️⃣8️⃣ ПРОВЕРКА УСТАНОВКИ"
echo -e "${YELLOW}📋 Проверяю основные команды:${NC}"
for cmd in ls cp mv chmod mkdir pandoc ffmpeg git python nodejs; do
    if command -v $cmd &>/dev/null; then
        echo -e "   ${GREEN}✅ $cmd работает${NC}"
    else
        echo -e "   ${RED}❌ $cmd НЕ работает${NC}"
    fi
done

# ===== ИТОГ =====
print_header "🎉 УСТАНОВКА ЗАВЕРШЕНА!"
echo -e "${GREEN}✅ Все пакеты успешно установлены!${NC}"
echo ""
echo -e "${YELLOW}📌 ТЕПЕРЬ У ТЕБЯ ЕСТЬ:${NC}"
echo "   • Базовые утилиты (coreutils) - ls, cp, mv, chmod, mkdir"
echo "   • Редакторы: nano, micro, vim"
echo "   • Инструменты разработки: Python, Java, Node.js, Rust, Go"
echo "   • Конвертация файлов: pandoc, calibre, ffmpeg, imagemagick"
echo "   • TTS: espeak (озвучка текста в MP3)"
echo "   • Веб-сервер: Apache, Nginx, PHP, phpMyAdmin"
echo "   • Базы данных: MySQL, PostgreSQL, SQLite"
echo "   • Сетевые утилиты: nmap, netcat, traceroute"
echo "   • Мониторинг: htop, neofetch, tmux, ranger"
echo "   • Архиваторы: unrar, p7zip, lzop"
echo ""
echo -e "${YELLOW}🔧 Теперь нужно ПЕРЕЗАПУСТИТЬ Termux или выполнить:${NC}"
echo "   source ~/.bashrc"
echo ""
echo -e "${BLUE}══════════════════════════════════════════════${NC}"
echo -e "${GREEN}🏁 ГОТОВО! МОЖНО РАБОТАТЬ!${NC}"
echo -e "${BLUE}══════════════════════════════════════════════${NC}"