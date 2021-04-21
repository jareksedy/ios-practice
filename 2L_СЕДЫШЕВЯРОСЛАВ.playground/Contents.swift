// Урок 2. Практическое задание.
// Ярослав Седышев <jareksedy@icloud.com>


// 1. Написать функцию, которая определяет, четное число или нет.

func isEven(_ n:Int) -> Bool {
    return n % 2 == 0
}


// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func isMultipleOf3(_ n:Int) -> Bool {
    return n % 3 == 0
}


// 3. Создать возрастающий массив из 100 чисел.

var tArr: [Int] = []

for i in 0...99 {
    tArr.append(i)
}


// 3. Создать возрастающий массив из 100 чисел (альтернативное решение).

tArr = Array(0...99)


// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for value in tArr {
    if isEven(value) || !isMultipleOf3(value) {
        tArr.remove(at: tArr.firstIndex(of: value)!)
    }
}


// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3 (альтернативное решение).

tArr = Array(0...99)
tArr.removeAll(where: {isEven($0) || !isMultipleOf3($0)})


// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

func appendFn(_ a: inout [Int]) {
    a.count <= 1 ? a.append(a.count) : a.append(a[a.count - 1] + a[a.count - 2])
}

var fibArr: [Int] = []

for _ in 0...49 {
    appendFn(&fibArr)
}


// 6. * Заполнить массив из 100 элементов различными простыми числами.

var pArr = Array(2...100)
var p = 0

while true {
    
    if let newPrimeIndex = pArr.firstIndex(where: { $0 > p }) {
        p = pArr[newPrimeIndex]
    } else { break }
    
    for value in pArr {
        if value % p == 0 && value != p {
            pArr.remove(at: pArr.firstIndex(of: value)!)
        }
    }
}


// 6. * Заполнить массив из 100 элементов различными простыми числами (альтернативное решение).

pArr = Array(2...100)
p = 0

while true {
    
    if let newPrimeIndex = pArr.firstIndex(where: { $0 > p }) {
        p = pArr[newPrimeIndex]
    } else { break }
    
    pArr.removeAll(where: { $0 % p == 0 && $0 != p })
}
