import math

def find2NOD(a,b):
    while b!=0:
        a,b = b,a % b
    return abs(a)

def find3NOD(a,b,c):
    return find2NOD(find2NOD(a,b), c)

def isPrime(n):
    if n<=1:return False
    if n==2: return True
    if n%2==0:return False
    
    for i in range(3, int(math.sqrt(n)) + 1, 2):
        if n%i == 0:
            return False
    return True

def findPrimes(n,m):
    primes = []
    for i in range(n,m):
        if isPrime(i):
            primes.append(i)
    return primes

print("1 - НОД")
print("2 - найти простые числа")
choice = input("выебрите действие (1 или 2): ")

if choice == "1":
    count  = int(input("2 или 3 числа? "))

    if count == 2:
        a = int(input("введите первое число: "))
        b = int(input("введите второе число: "))
        print("НОД(", a,",", b, ") = ", find2NOD(a,b))

    elif count == 3:
        a = int(input("введите первое число: "))
        b = int(input("введите второе число: "))
        c = int(input("введите третье число: "))
        print("НОД(", a,",", b,",", c, ") = ", find3NOD(a,b,c))

    else:
        print("выберите корректный вариант работы")

elif choice == "2":
    n = int(input("введите n: "))
    m = int(input("введите m: "))
    primes = findPrimes(n,m)
    print("простые числа: ", primes)

else:
    print("выберите корректный вариант работы")