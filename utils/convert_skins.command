#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# chmod +x convert_skins.command
# Double click to execute bash script.

import os
from PIL import Image

# Папка с исходными скинами
input_folder = "minecraft_skins"
# Папки для сохранения обработанных файлов
output_text_folder = "../meta"       # На один уровень вверх для текстовых файлов
output_image_folder = "../textures"  # На один уровень вверх для PNG файлов

# Убедимся, что папки для сохранения существуют
os.makedirs(output_text_folder, exist_ok=True)
os.makedirs(output_image_folder, exist_ok=True)

# Задаем параметры вырезки
x, y = 0, 0  # Координаты верхнего левого угла
width, height = 64, 32  # Размеры области

# Обрабатываем каждый файл в папке input_folder
for filename in os.listdir(input_folder):
    # Проверяем, что файл является PNG-изображением
    if filename.endswith(".png"):
        # Полные пути к файлам
        input_path = os.path.join(input_folder, filename)
        output_image_path = os.path.join(output_image_folder, filename)
        output_text_path = os.path.join(output_text_folder, f"{os.path.splitext(filename)[0]}.txt")
        
        # Открываем исходное изображение
        with Image.open(input_path) as img:
            # Вырезаем область 64x32
            cropped_image = img.crop((x, y, x + width, y + height))
            # Сохраняем вырезанное изображение
            cropped_image.save(output_image_path)
        
        # Создаем текстовый файл и записываем строку gender="male"
        with open(output_text_path, "w") as text_file:
            text_file.write('gender="male"')

print("Обработка завершена! PNG файлы сохранены в '../textures', а текстовые файлы - в '../meta'.")