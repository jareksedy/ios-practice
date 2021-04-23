// Урок 3. Практическое задание.
// Ярослав Седышев <jareksedy@icloud.com>

// 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
// 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.

// Возможные цвета

enum CarColors {
    case white
    case black
    case gray
    case silver
    case blue
    case red
    case beige

    var description: String {
        switch self {
        case .white:
            return "БЕЛЫЙ"
        case .black:
            return "ЧЕРНЫЙ"
        case .gray:
            return "СЕРЫЙ"
        case .silver:
            return "СЕРЕБРИСТЫЙ"
        case .blue:
            return "ГОЛУБОЙ"
        case .red:
            return "КРАСНЫЙ"
        case .beige:
            return "БЕЖЕВЫЙ"
        }
    }
    
}

// Состояние двигателя

enum CarEngine {
    case on, off
    
    var description: String {
        switch self {
        case .on:
            return "ЗАПУЩЕН"
        case .off:
            return "ЗАГЛУШЕН"
        }
    }
}

// Состояние окон

enum CarWindows {
    case open, closed

    var description: String {
        switch self {
        case .open:
            return "ОТКРЫТЫ"
        case .closed:
            return "ЗАКРЫТЫ"
        }
    }
}

// Состояние дверей

enum CarDoors {
    case open, closed

    var description: String {
        switch self {
        case .open:
            return "РАЗБЛОКИРОВАНЫ"
        case .closed:
            return "ЗАБЛОКИРОВАНЫ"
        }
    }
}

// Действия с автомобилем

enum CarActions {
    case unlock
    case lock
    case openWindows
    case closeWindows
}

// Легковой автомобиль

struct SportCar {
    
    let make: String                                    // Марка авто
    let model: String                                   // Модель авто
    let modelYear: Int                                  // Год выпуска
    let color: CarColors                                // Цвет авто
    let bootCapacity: Int                               // Объем багажника в дм³
    
    var bootLoaded: Int                                 // Заполнение багажника в дм³
    
    var engineStatus: CarEngine                         // Состояние двигателя
    var windowStatus: CarWindows                        // Состояние окон
    var doorStatus:   CarDoors                          // Состояние дверей
    
    // Текстовые сообщения
    
    let errNotEnoughSpace: String = "ОШИБКА: В БАГАЖНИКЕ НЕДОСТАТОЧНО МЕСТА. ОСВОБОДИТЕ БАГАЖНИК."
    let errOverCapacity: String = "ОШИБКА: ОБЪЕМ БАГАЖА ПРЕВЫШАЕТ ОБЪЕМ БАГАЖНИКА."
    let errEngineOff: String = "ОШИБКА: ЗАПУСТИТЕ ДВИГАТЕЛЬ ПРЕЖДЕ ЧЕМ ОТКРЫТЬ ОКНО."
    let errNotValid: String = "ОШИБКА: ОБЪЕМ ЗАГРУЖАЕМОГО БАГАЖА ДОЛЖЕН БЫТЬ ПОЛОЖИТЕЛЬНЫМ ЧИСЛОМ."
    let msgUnlock:String = "ДВЕРИ АВТО РАЗБЛОКИРОВАНЫ, ДВИГАТЕЛЬ ЗАПУЩЕН, МОЖНО ЕХАТЬ!"
    let msgLock:String = "ДВЕРИ АВТО ЗАБЛОКИРОВАНЫ, ДВИГАТЕЛЬ ЗАГЛУШЕН."
    let msgWindowsOpen:String = "ОКНА ВАШЕГО АВТО ОТКРЫТЫ."
    let msgWindowsClose:String = "ОКНА ВАШЕГО АВТО ЗАКРЫТЫ."
    
    // Методы для запуска/заглушения двигателя
    
    mutating func startEngine() {
        if self.engineStatus == CarEngine.off { self.engineStatus = CarEngine.on }
    }

    mutating func stopEngine() {
        if self.engineStatus == CarEngine.on { self.engineStatus = CarEngine.off }
    }

    // Методы для открытия/закрытия окон
    
    mutating func openWindows() {
        if self.windowStatus == CarWindows.closed { self.windowStatus = CarWindows.open }
    }

    mutating func closeWindows() {
        if self.windowStatus == CarWindows.open { self.windowStatus = CarWindows.closed }
    }

    // Методы для открытия/закрытия дверей
    
    mutating func openDoors() {
        if self.doorStatus == CarDoors.closed { self.doorStatus = CarDoors.open }
    }

    mutating func closeDoors() {
        if self.doorStatus == CarDoors.open { self.doorStatus = CarDoors.closed }
    }
    
    // Методы для загрузки/выгрузки багажа передается объем багажа для загрузки/выгрузки в дм³
    
    mutating func load(volume: Int) {
        if volume + self.bootLoaded <= self.bootCapacity {
            self.bootLoaded += volume
            print("БАГАЖНИК ЗАГРУЖЕН НА ДОПОЛНИТЕЛЬНЫЕ \(volume) ДМ³. ОБЩАЯ ЗАГРУЗКА БАГАЖНИКА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%).")
        } else {
            volume > self.bootCapacity ? print(errOverCapacity) : print(errNotEnoughSpace)
        }
    }
    
    mutating func unload(volume: Int) {
        self.bootLoaded = max(self.bootLoaded - volume, 0)
        print("БАГАЖНИК РАЗГРУЖЕН НА \(volume) ДМ³. ОБЩАЯ ЗАГРУЗКА БАГАЖНИКА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%).")
    }
    
    mutating func unloadAll() {
        self.bootLoaded = 0
        print("БАГАЖНИК ПОЛНОСТЬЮ РАЗГРУЖЕН.")
    }
    
    mutating func performAction(action: CarActions) {
        
        switch action {
        
        case CarActions.unlock:
            
            self.openDoors()
            self.startEngine()
            print(msgUnlock)
            
        case CarActions.lock:
            
            self.closeDoors()
            self.stopEngine()
            print(msgLock)

        case .openWindows:
            
            if self.engineStatus == CarEngine.on {
                
                self.openWindows()
                print(msgWindowsOpen)
                
            } else {
                
                print(errEngineOff)
                
            }
            
        case .closeWindows:
            
            self.closeWindows()
            print(msgWindowsClose)
            
        }
    }
    
    mutating func info() {
        
        print("""
            ИНФОРМАЦИЯ О ЛЕГКОВОМ АВТОМОБИЛЕ
            --------------------------------
            МАРКА           : \(self.make)
            МОДЕЛЬ          : \(self.model)
            ГОД ВЫПУСКА     : \(self.modelYear)
            ЦВЕТ            : \(self.color.description)
            ОБЪЕМ БАГАЖНИКА : \(self.bootCapacity) ДМ³

            СОСТОЯНИЕ
            --------------------------------
            ДВИГАТЕЛЬ       : \(self.engineStatus.description)
            ДВЕРИ           : \(self.doorStatus.description)
            ОКНА            : \(self.windowStatus.description)
            БАГАЖНИК        : ЗАГРУЖЕН НА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%)
            \n
            """)
        
    }
    
    init (carMake:String, carModel:String, carModelYear:Int, carColor:CarColors, carBootCapacity:Int) {
        self.make = carMake
        self.model = carModel
        self.modelYear = carModelYear
        self.color = carColor
        self.bootCapacity = carBootCapacity
        
        self.bootLoaded = 0
        self.engineStatus = CarEngine.off
        self.doorStatus = CarDoors.closed
        self.windowStatus = CarWindows.closed
    }
}

// Грузовой автомобиль

struct TrunkCar {
    
    let make: String                                    // Марка авто
    let model: String                                   // Модель авто
    let modelYear: Int                                  // Год выпуска
    let color: CarColors                                // Цвет авто
    let bootCapacity: Int                               // Объем кузова грузовика в дм³
    
    var bootLoaded: Int                                 // Заполнение кузова грузовика в дм³
    
    var engineStatus: CarEngine                         // Состояние двигателя
    
    // Текстовые сообщения
    
    let errNotEnoughSpace: String = "ОШИБКА: В КУЗОВЕ ГРУЗОВИКА НЕДОСТАТОЧНО МЕСТА. ОСВОБОДИТЕ КУЗОВ ГРУЗОВИКА."
    let errOverCapacity: String = "ОШИБКА: ОБЪЕМ БАГАЖА ПРЕВЫШАЕТ ОБЪЕМ КУЗОВА ГРУЗОВИКА."
    let errNotValid: String = "ОШИБКА: ОБЪЕМ ЗАГРУЖАЕМОГО БАГАЖА ДОЛЖЕН БЫТЬ ПОЛОЖИТЕЛЬНЫМ ЧИСЛОМ."

    // Методы для запуска/заглушения двигателя
    
    mutating func startEngine() {
        if self.engineStatus == CarEngine.off { self.engineStatus = CarEngine.on }
    }

    mutating func stopEngine() {
        if self.engineStatus == CarEngine.on { self.engineStatus = CarEngine.off }
    }
    
    // Методы для загрузки/выгрузки багажа передается объем багажа для загрузки/выгрузки в дм³
    
    mutating func load(volume: Int) {
        if volume + self.bootLoaded <= self.bootCapacity {
            self.bootLoaded += volume
            print("КУЗОВ ЗАГРУЖЕН НА ДОПОЛНИТЕЛЬНЫЕ \(volume) ДМ³. ОБЩАЯ ЗАГРУЗКА КУЗОВА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%).")
        } else {
            volume > self.bootCapacity ? print(errOverCapacity) : print(errNotEnoughSpace)
        }
    }
    
    mutating func unload(volume: Int) {
        self.bootLoaded = max(self.bootLoaded - volume, 0)
        print("КУЗОВ РАЗГРУЖЕН НА \(volume) ДМ³. ОБЩАЯ ЗАГРУЗКА КУЗОВА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%).")
    }
    
    mutating func unloadAll() {
        self.bootLoaded = 0
        print("КУЗОВ ПОЛНОСТЬЮ РАЗГРУЖЕН.")
    }
    
    
    mutating func info() {
        
        print("""
            ИНФОРМАЦИЯ О ГРУЗОВОМ АВТОМОБИЛЕ
            --------------------------------
            МАРКА           : \(self.make)
            МОДЕЛЬ          : \(self.model)
            ГОД ВЫПУСКА     : \(self.modelYear)
            ЦВЕТ            : \(self.color.description)
            ОБЪЕМ БАГАЖНИКА : \(self.bootCapacity) ДМ³

            СОСТОЯНИЕ
            --------------------------------
            ДВИГАТЕЛЬ       : \(self.engineStatus.description)
            КУЗОВ ГРУЗОВИКА : ЗАГРУЖЕН НА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%)
            \n
            """)
        
    }
    
    init (carMake:String, carModel:String, carModelYear:Int, carColor:CarColors, carBootCapacity:Int) {
        self.make = carMake
        self.model = carModel
        self.modelYear = carModelYear
        self.color = carColor
        self.bootCapacity = carBootCapacity
        
        self.bootLoaded = 0
        self.engineStatus = CarEngine.off
    }
}


// 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
// 6. Вывести значения свойств экземпляров в консоль.

var myCar1 = SportCar(carMake: "LEXUS", carModel: "LC 500", carModelYear: 2019, carColor: CarColors.red, carBootCapacity: 197)
var myCar2 = TrunkCar(carMake: "CHEVROLET", carModel: "SILVERADO", carModelYear: 2021, carColor: CarColors.silver, carBootCapacity: 1784)

myCar1.info()
myCar2.info()

myCar1.performAction(action: CarActions.unlock)
myCar1.openWindows()

myCar2.startEngine()

myCar1.load(volume: 200)
myCar1.load(volume: 190)
myCar1.load(volume: 100)
myCar1.unloadAll()
myCar1.load(volume: 100)

myCar2.load(volume: 1700)
myCar2.load(volume: 1700)
myCar2.unload(volume: 1000)
myCar2.load(volume: 700)

myCar1.closeWindows()

print("\n")

myCar1.info()
myCar2.info()
