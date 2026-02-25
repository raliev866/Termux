

## Для автоформатирования док файлов сы создали файл elegant.docx и с его форматов считывает термукс и автоматически форматирую создаваемые текстовые файлы. Можно ли сделать тоже самое и для конвертируемых HTML файлов. Чтобы автоформатирование происходило согласно определённым стандартам? Если да, то надо создать лучшие стандарты для чтения текстов, книг. Но эти книги научные а не литературные.

___

### /Documents/15_Настройки_скрипты_Termux_бекап_рестор/Шаблон формата текста/HTML книги/




## 🎯 Лучшие стандарты для **научных HTML-книг**

На основе анализа современных решений , вот идеальные настройки для научных текстов:

### Основной CSS-файл `scientific-book.css`

## Рекомендации по настройке

Для максимального комфорта чтения научных текстов:

1. **Шрифт**: Georgia или PT Serif (отлично для русского)
2. **Размер**: 18px на десктопе, 16px на мобильных
3. **Интервал**: 1.5-1.7 (обязательно)
4. **Ширина строки**: 60-75 символов (у нас ~800px)
5. **Контраст**: Не чисто черный на белом, а мягкие оттенки

Отлично! Создадим всё в указанной папке. Вот **полный скрипт** с правильными путями:

```bash
#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# МДГТМЛ - Конвертер Markdown в HTML (v3.0)
# ==============================================
# Папки настроены под вашу структуру

WORK_DIR="$HOME/storage/shared/Documents/03_md_html_мдгтмл"
TEMPLATE_DIR="$HOME/storage/shared/Documents/15_Настройки_скрипты_Termux_бекап_рестор/Шаблон формата текста/HTML книги"
TEMPLATE="$TEMPLATE_DIR/шаблон_научной_книги.html"
CSS_FILE="$TEMPLATE_DIR/scientific_style.css"

# Создаем папку для шаблонов если её нет
mkdir -p "$TEMPLATE_DIR"

# СОЗДАЕМ ФАЙЛ СТИЛЕЙ (CSS)
if [ ! -f "$CSS_FILE" ]; then
    echo "📝 Создаю файл стилей: scientific_style.css"
    cat > "$CSS_FILE" << 'EOF'
/* ============================================
   НАУЧНЫЙ СТИЛЬ ДЛЯ HTML-КНИГ
   ============================================ */

:root {
    --font-serif: 'Georgia', 'Times New Roman', serif;
    --font-sans: 'Helvetica', 'Arial', sans-serif;
    --font-mono: 'Courier New', monospace;
    --body-font-size: 18px;
    --body-line-height: 1.7;
    --max-width: 800px;
    --text-color: #2c3e50;
    --bg-color: #fafafa;
    --heading-color: #1a5a9c;
    --code-bg: #f0f0f0;
    --border-color: #ddd;
}

body {
    font-family: var(--font-serif);
    font-size: var(--body-font-size);
    line-height: var(--body-line-height);
    color: var(--text-color);
    background: var(--bg-color);
    max-width: var(--max-width);
    margin: 0 auto;
    padding: 30px 20px;
}

/* Заголовки */
h1, h2, h3, h4, h5, h6 {
    color: var(--heading-color);
    margin-top: 1.8em;
    margin-bottom: 0.6em;
    font-weight: 600;
}

h1 { 
    font-size: 2.2em; 
    border-bottom: 3px solid #3498db;
    padding-bottom: 12px;
}
h2 { 
    font-size: 1.8em; 
    border-bottom: 2px solid #bdc3c7;
    padding-bottom: 8px;
}
h3 { font-size: 1.5em; }
h4 { font-size: 1.3em; font-style: italic; }
h5 { font-size: 1.1em; }
h6 { font-size: 1em; color: #666; }

/* Основной текст */
p {
    margin-bottom: 1.2em;
    text-align: justify;
}

/* Код */
code {
    font-family: var(--font-mono);
    background: var(--code-bg);
    padding: 2px 5px;
    border-radius: 3px;
    color: #c0392b;
    font-size: 0.9em;
}

pre {
    background: #2c3e50;
    color: #ecf0f1;
    padding: 20px;
    border-radius: 8px;
    overflow-x: auto;
    font-family: var(--font-mono);
    font-size: 15px;
    border-left: 5px solid #e74c3c;
    margin: 1.5em 0;
}

pre code {
    background: none;
    color: inherit;
    padding: 0;
}

/* Цитаты */
blockquote {
    border-left: 5px solid #3498db;
    background: #ecf0f1;
    padding: 15px 25px;
    margin: 1.5em 0;
    border-radius: 0 8px 8px 0;
    font-style: italic;
    font-size: 0.95em;
}

/* Таблицы */
table {
    border-collapse: collapse;
    width: 100%;
    margin: 1.5em 0;
    font-size: 0.95em;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

th {
    background: #3498db;
    color: white;
    font-weight: 600;
    padding: 12px;
    text-align: left;
}

td {
    border: 1px solid var(--border-color);
    padding: 10px;
}

tr:nth-child(even) { background: #f8f9fa; }
tr:hover { background: #e8f4fd; }

/* Изображения */
img {
    max-width: 100%;
    height: auto;
    border-radius: 5px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    margin: 1.5em 0;
    display: block;
}

/* Подписи */
figcaption, .caption {
    font-size: 0.9em;
    color: #666;
    text-align: center;
    margin-top: -1em;
    margin-bottom: 1.5em;
    font-style: italic;
}

/* Сноски */
.footnotes {
    margin-top: 3em;
    padding-top: 1.5em;
    border-top: 2px solid #ccc;
    font-size: 0.9em;
}

.footnotes li {
    margin-bottom: 0.5em;
}

/* Оглавление */
nav#toc {
    background: #f8f9fa;
    padding: 20px 30px;
    border-radius: 8px;
    margin: 2em 0;
    border: 1px solid #ddd;
}

nav#toc ul {
    list-style-type: none;
    padding-left: 20px;
}

nav#toc li {
    margin: 8px 0;
}

nav#toc a {
    color: #2980b9;
    text-decoration: none;
}

nav#toc a:hover {
    text-decoration: underline;
}

/* Адаптация под мобильные */
@media (max-width: 600px) {
    body {
        font-size: 16px;
        padding: 15px;
    }
    h1 { font-size: 1.8em; }
    h2 { font-size: 1.5em; }
    pre { font-size: 14px; }
    table { font-size: 0.85em; }
}

/* Печатная версия */
@media print {
    body {
        font-size: 12pt;
        background: white;
        color: black;
    }
    pre {
        background: #f5f5f5;
        color: black;
        border: 1px solid #ccc;
    }
    nav#toc { display: none; }
}
EOF
    echo "   ✅ Файл стилей создан"
fi

# СОЗДАЕМ HTML ШАБЛОН
if [ ! -f "$TEMPLATE" ]; then
    echo "📝 Создаю HTML шаблон: шаблон_научной_книги.html"
    pandoc -D html > "$TEMPLATE"
    echo "   ✅ Шаблон создан"
fi

echo "=============================================="
echo "     КОНВЕРТАЦИЯ MARKDOWN → HTML"
echo "=============================================="
echo "📁 Рабочая папка: $WORK_DIR"
echo "📁 Шаблоны: $TEMPLATE_DIR"
echo "🎨 Стили: scientific_style.css"
echo "📄 Шаблон: шаблон_научной_книги.html"
echo ""

# Проверяем существует ли рабочая папка
if [ ! -d "$WORK_DIR" ]; then
    echo "📁 Папка $WORK_DIR не существует! Создаю..."
    mkdir -p "$WORK_DIR"
fi

# Счётчики
FILES_FOUND=0
FILES_CONVERTED=0

echo "🔍 Поиск файлов .md в рабочей папке..."
echo ""

# Конвертация всех .md файлов
for file in "$WORK_DIR"/*.md; do
    if [ -f "$file" ]; then
        FILES_FOUND=$((FILES_FOUND + 1))
        filename=$(basename "$file" .md)
        output_file="$WORK_DIR/$filename.html"
        
        echo "📄 [$FILES_FOUND] Конвертирую: $filename.md"
        
        pandoc "$file" -o "$output_file" \
            --template="$TEMPLATE" \
            --css="$CSS_FILE" \
            --standalone \
            --toc \
            --toc-depth=3 \
            --number-sections \
            --metadata title="$filename" \
            --metadata lang="ru-RU"
        
        if [ $? -eq 0 ] && [ -f "$output_file" ]; then
            echo "      ✅ Создан: $filename.html"
            FILES_CONVERTED=$((FILES_CONVERTED + 1))
        else
            echo "      ❌ Ошибка конвертации"
        fi
    fi
done

echo ""
echo "=============================================="
echo "✅ КОНВЕРТАЦИЯ ЗАВЕРШЕНА"
echo "📊 Найдено файлов: $FILES_FOUND"
echo "🔄 Сконвертировано: $FILES_CONVERTED"
echo "=============================================="
echo ""
echo "📁 Файлы сохранены в: $WORK_DIR"
echo "🎨 Шаблон и стили: $TEMPLATE_DIR"
```

## Как установить и запустить:


# 1. Создайте новый скрипт (удалив старый)
nano ~/storage/shared/Documents/15_Настройки_скрипты_Termux_бекап_рестор/Алиасы_команды_SH/мдгтмл.sh

# 2. Удалите всё старое и вставьте новый код выше

# 3. Сохраните: Ctrl+X → Y → Enter

# 4. Сделайте исполняемым
```bash
chmod +x ~/storage/shared/Documents/15_Настройки_скрипты_Termux_бекап_рестор/Алиасы_команды_SH/мдгтмл.sh
```
# 5. Запустите!
мдгтмл




###  Что будет создано:

После первого запуска в папке:
```
/Documents/15_Настройки_скрипты_Termux_бекап_рестор/Шаблон формата текста/HTML книги/
```

появятся два файла:
- `scientific_style.css` — файл со стилями
- `шаблон_научной_книги.html` — HTML шаблон

Все HTML файлы в папке `03_md_html_мдгтмл` будут создаваться с применением этих стилей!

