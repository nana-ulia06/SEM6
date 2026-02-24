import time
from collections import Counter

ALPHABET = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
N = len(ALPHABET)
FILLER = "Х"

def split_bigrams(text):
    text = text.upper()
    cleaned = ""

    for char in text:
        if char in ALPHABET:
            cleaned += char

    if len(cleaned) % 2 != 0:
        cleaned += FILLER

    bigrams = []
    for i in range(0, len(cleaned), 2):
        bigrams.append(cleaned[i:i+2])

    return bigrams

def encryptPorts(text):
    bigrams = split_bigrams(text)
    result = []

    for pair in bigrams:
        row = ALPHABET.index(pair[0])
        col = ALPHABET.index(pair[1])

        number = row * N + col + 1
        result.append(f"{number:03d}")  # формат с ведущими нулями

    return " ".join(result)

def decryptPorts(cipher_text):
    numbers = cipher_text.split()
    result = ""

    for num in numbers:
        number = int(num) - 1
        row = number // N
        col = number % N

        result += ALPHABET[row] + ALPHABET[col]

    return result

def generateKeyAlphabet(keyword):
    keyword = keyword.upper()
    key_unique = ""

    for char in keyword:
        if char in ALPHABET and char not in key_unique:
            key_unique += char

    for char in ALPHABET:
        if char not in key_unique:
            key_unique += char

    return key_unique

def encryptCezar(text, keyword):
    key_alphabet = generateKeyAlphabet(keyword)
    result = ""

    for char in text.upper():
        if char in ALPHABET:
            index = ALPHABET.index(char)
            result += key_alphabet[index]
        else:
            result += char

    return result

def decryptCezar(text, keyword):
    key_alphabet = generateKeyAlphabet(keyword)
    result = ""

    for char in text.upper():
        if char in key_alphabet:
            index = key_alphabet.index(char)
            result += ALPHABET[index]
        else:
            result += char

    return result

with open("input.txt", "r", encoding="utf-8") as file:
    text = file.read()

keyword = "ДУЖИК"

startEP = time.perf_counter()
encryptedPorts = encryptPorts(text)
endEP = time.perf_counter()
print("Время шифрования шифром Порты: ", endEP - startEP, " сек")

with open("encryptedPorts.txt", "w", encoding="utf-8") as f1:
    f1.write(encryptedPorts)

startDP = time.perf_counter()
decryptedPorts = decryptPorts(encryptedPorts)
endDP = time.perf_counter()
print("Время дешифрования шифром Порты: ", endDP - startDP, " сек")

with open("decryptedPorts.txt", "w", encoding="utf-8") as f2:
    f2.write(decryptedPorts)

startEC = time.perf_counter()
encryptedCezar = encryptCezar(text, keyword)
endEC = time.perf_counter()
print("Время шифрования шифром Цезаря с ключевым словом: ", endEC - startEC, " сек")

with open("encryptedCezar.txt", "w", encoding="utf-8") as f3:
    f3.write(encryptedCezar)

startDC = time.perf_counter()
decryptedCezar = decryptCezar(encryptedCezar, keyword)
endDC = time.perf_counter()
print("Время дешифрования шифром Цезаря с ключевым словом: ", endDC - startDC, " сек")

with open("decryptedCezar.txt", "w", encoding="utf-8") as f4:
    f4.write(decryptedCezar)