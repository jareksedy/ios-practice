// Урок 5. Практическое задание.
// Ярослав Седышев <jareksedy@icloud.com>

// Действия с автомобилем

enum Action {
    
    case doorsUnlock
    case doorsLock
    case engineStart
    case engineStop
    
    // Уникальные действия с легковым (спортивным) автомобилем
    
    case boot
    case unboot
    
    // Уникальные действия с грузовым автомобилем
    
    case loadCargo
    case unloadCargo
    
}

// Цвета авто

enum Color {
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

enum Engine {
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

// Состояние дверей

enum Doors {
    case unlocked, locked

    var description: String {
        switch self {
        case .unlocked:
            return "РАЗБЛОКИРОВАНЫ"
        case .locked:
            return "ЗАБЛОКИРОВАНЫ"
        }
    }
}

// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

protocol Car {
        
    // Свойства
    
    var make: String {get}                                    // Марка авто
    var model: String {get}                                   // Модель авто
    var modelYear: Int {get}                                  // Год выпуска
    var color: Color {get}                                    // Цвет авто
    
    var engineState: Engine {get set}                         // Состояние двигателя
    var doorState: Doors {get set}                            // Состояние дверей
    
    func performAction(_ action: Action, volume :Int?) -> Void
    
}

// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

extension Car {
    
    // Запуск двигателя
    
    func startEngine(e: inout Engine) {
        e = Engine.on
    }
    
    // Заглушение двигателя
    
    func stopEngine(e: inout Engine) {
        e = Engine.off
    }
    
    // Разблокировка дверей
    
    func unlockDoors(d: inout Doors) {
        d = Doors.unlocked
    }
    
    // Блокировка дверей
    
    func lockDoors(d: inout Doors) {
        d = Doors.locked
    }
}


// 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class SportsCar: Car {
        
    var make: String                                    // Марка авто
    var model: String                                   // Модель авто
    var modelYear: Int                                  // Год выпуска
    var color: Color                                    // Цвет авто
    
    var engineState: Engine                             // Состояние двигателя
    {
        didSet {
            print("ДВИГАТЕЛЬ \(self.make) \(self.model) \(self.engineState.description).")
        }
    }
    
    var doorState: Doors                                // Состояние дверей
    {
        didSet {
            print("ДВЕРИ \(self.make) \(self.model) \(self.doorState.description).")
        }
    }
    
    // Уникальные свойства класса — объем багажника и заполнение багажника.
    
    var bootCapacity: Int                               // Объем багажника в дм³
    private var bootLoaded: Int                         // Заполнение багажника в дм³
    {
        didSet {
            print("БАГАЖНИК \(self.make) \(self.model) ТЕПЕРЬ ЗАПОЛНЕН НА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%).")
        }
    }

    // Инициализатор
    
    init(make: String, model: String, modelYear: Int, color: Color, bootCapacity: Int) {
            
        self.make = make
        self.model = model
        self.modelYear = modelYear
        self.color = color
        self.bootCapacity = bootCapacity
        
        self.engineState = .off
        self.doorState = .locked
        
        self.bootLoaded = 0
                   
    }
    
    // Действия с легковым авто
    
    func performAction(_ action: Action, volume :Int? = nil) {

        switch action {
        
        case .engineStop:
            self.stopEngine(e: &self.engineState)
            
        case .engineStart:
            self.startEngine(e: &self.engineState)
            
        case .doorsLock:
            self.lockDoors(d: &self.doorState)
 
        case .doorsUnlock:
            self.unlockDoors(d: &self.doorState)
    
        // Уникальные действия для легкового авто
        
        case .boot:
            if let vol = volume {
            self.bootLoaded = min(self.bootLoaded + vol, self.bootCapacity)
            }
            
        case .unboot:
            if let vol = volume {
            self.bootLoaded = max(self.bootLoaded - vol, 0)
            }
        
        default: ()
            
        }
    }
}

class TrunkCar: Car {
        
    var make: String                                    // Марка авто
    var model: String                                   // Модель авто
    var modelYear: Int                                  // Год выпуска
    var color: Color                                    // Цвет авто
    
    var engineState: Engine                             // Состояние двигателя
    {
        didSet {
            print("ДВИГАТЕЛЬ \(self.make) \(self.model) \(self.engineState.description).")
        }
    }
    
    var doorState: Doors                                // Состояние дверей
    {
        didSet {
            print("ДВЕРИ \(self.make) \(self.model) \(self.doorState.description).")
        }
    }
    
    // Уникальные свойства класса — объем кузова и заполнение кузова.
    
    var cargoCapacity: Int                               // Объем кузова в дм³
    private var cargoLoaded: Int                                 // Заполнение кузова в дм³
    {
        didSet {
            print("КУЗОВ \(self.make) \(self.model) ТЕПЕРЬ ЗАГРУЖЕН НА \(self.cargoLoaded) ДМ³ (\(self.cargoLoaded * 100 / self.cargoCapacity)%).")
        }
    }

    // Инициализатор
    
    init(make: String, model: String, modelYear: Int, color: Color, cargoCapacity: Int) {
            
        self.make = make
        self.model = model
        self.modelYear = modelYear
        self.color = color
        self.cargoCapacity = cargoCapacity
        
        self.engineState = .off
        self.doorState = .locked
        
        self.cargoLoaded = 0
                   
    }
    
    // Действия с грузовым авто
    
    func performAction(_ action: Action, volume :Int? = nil) {
        
        switch action {
        
        case .engineStop:
            self.stopEngine(e: &self.engineState)
            
        case .engineStart:
            self.startEngine(e: &self.engineState)
            
        case .doorsLock:
            self.lockDoors(d: &self.doorState)
 
        case .doorsUnlock:
            self.unlockDoors(d: &self.doorState)
    
        // Уникальные действия для грузового авто
        
        case .loadCargo:
            if let vol = volume {
            self.cargoLoaded = min(self.cargoLoaded + vol, self.cargoCapacity)
            }
            
        case .unloadCargo:
            if let vol = volume {
            self.cargoLoaded = max(self.cargoLoaded - vol, 0)
            }
        
        default: ()
            
        }
    }
}


// 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

extension SportsCar: CustomStringConvertible {
    
    var description: String {
        
        return
            
            """
            \n
            --------------------------------
            ИНФОРМАЦИЯ О ЛЕГКОВОМ АВТОМОБИЛЕ
            --------------------------------
            МАРКА И МОДЕЛЬ  : \(self.make) \(self.model)
            ГОД ВЫПУСКА     : \(self.modelYear)
            ЦВЕТ            : \(self.color.description)
            ОБЪЕМ БАГАЖНИКА : \(self.bootCapacity) ДМ³
            ЗАГРУЖЕН НА     : \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%)
            ДВИГАТЕЛЬ       : \(self.engineState.description)
            ДВЕРИ           : \(self.doorState.description)
            """
        
    }
}

extension TrunkCar: CustomStringConvertible {
    
    var description: String {
        
        return
            
            """
            \n
            --------------------------------
            ИНФОРМАЦИЯ О ГРУЗОВОМ АВТОМОБИЛЕ
            --------------------------------
            МАРКА И МОДЕЛЬ  : \(self.make) \(self.model)
            ГОД ВЫПУСКА     : \(self.modelYear)
            ЦВЕТ            : \(self.color.description)
            ОБЪЕМ КУЗОВА    : \(self.cargoCapacity) ДМ³
            ЗАГРУЖЕН НА     : \(self.cargoLoaded) ДМ³ (\(self.cargoLoaded * 100 / self.cargoCapacity)%)
            ДВИГАТЕЛЬ       : \(self.engineState.description)
            ДВЕРИ           : \(self.doorState.description)
            """
        
    }
}


// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

var myCar1 = SportsCar(make: "LEXUS", model: "LC 500", modelYear: 2019, color: Color.red, bootCapacity: 197)
var myCar2 = TrunkCar(make: "CHEVROLET", model: "SILVERADO", modelYear: 2021, color: Color.silver, cargoCapacity: 1784)

myCar1.performAction(.engineStart)
myCar2.performAction(.engineStart)

myCar1.performAction(.doorsUnlock)
myCar2.performAction(.doorsUnlock)
myCar2.performAction(.doorsLock)
myCar2.performAction(.engineStop)

myCar1.performAction(.boot, volume: 190)
myCar1.performAction(.unboot, volume: 90)
myCar2.performAction(.loadCargo, volume: 1500)

// 6. Вывести сами объекты в консоль.

print(myCar1)
print(myCar2)
