from collections import Counter

print("введите название файла")
inputText = input()

with open(inputText, "r", encoding="utf-8") as f1:
    text = f1.read().upper()

frequency = Counter(text)

ALPHABET = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
sortedFreq = {char: frequency.get(char, 0) for char in ALPHABET}

print("Частота символов: ")
for char, count in sortedFreq.items():
    print(f"{char}: {count}")