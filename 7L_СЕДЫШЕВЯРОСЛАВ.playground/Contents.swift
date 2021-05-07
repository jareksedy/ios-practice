// Урок 7. Практическое задание.
// Ярослав Седышев <jareksedy@icloud.com>

import Foundation

// 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

class User {
    
    enum ValidationError: Error, LocalizedError {
        case emptyName, nameTooShort
        var errorDescription: String? {
            switch self {
            case .emptyName: return NSLocalizedString("Пустая строка имени.", comment: "")
            case .nameTooShort: return NSLocalizedString("Слишком короткое имя, имя должно содержать минимум 2 символа.", comment: "")
            }
        }
    }
    
    let userName: String
    
    init(_ name: String){
        userName = name
    }
    
    func validate() -> Error? {
        switch userName.count {
        case 0:
            return ValidationError.emptyName
        case 1:
            return ValidationError.nameTooShort
        default:
            return nil
        }
    }
}

let myUser1 = User("")
if let myErr = myUser1.validate() {
    print("ОШИБКА: " + myErr.localizedDescription)
} else {
    print("С именем \(myUser1.userName) все в порядке!")
}

let myUser2 = User("Я")
if let myErr = myUser2.validate() {
    print("ОШИБКА: " + myErr.localizedDescription)
} else {
    print("С именем \(myUser2.userName) все в порядке!")
}

let myUser3 = User("Ярослав")
if let myErr = myUser3.validate() {
    print("ОШИБКА: " + myErr.localizedDescription)
} else {
    print("С именем \(myUser3.userName) все в порядке!")
}


// 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

class URLValidator {
    
    enum URLError: Error {
        case badURL
    }
    
    init(_ urlString: String) throws {
        guard let _ = URL(string: urlString) else {
            throw URLError.badURL
        }
    }
}


do {
try URLValidator("https://google.com/")
}
catch URLValidator.URLError.badURL {
    print("ОШИБКА: Некорректный URL.")
    exit(1)
}

print("URL корректный, можно идти дальше!")


do {
    try URLValidator("абракадабра")
}
catch URLValidator.URLError.badURL {
    print("ОШИБКА: Некорректный URL.")
    exit(1)
}

print("URL корректный, можно идти дальше!")
