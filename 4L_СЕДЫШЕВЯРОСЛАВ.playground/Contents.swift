// Урок 4. Практическое задание.
// Ярослав Седышев <jareksedy@icloud.com>
 
// 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

class Car {
        
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

    // Свойства класса
    
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
    
    // Инициализатор
    
    init(make: String, model: String, modelYear: Int, color: Car.Color) {
        
        self.make = make
        self.model = model
        self.modelYear = modelYear
        self.color = color
        
        engineState = Engine.off
        doorState = Doors.locked
        
    }
        
    // Пустой метод действия с автомобилем
    
    func performAction() {
        
    }
    
    // Метод с информацией об авто
    
    func info() {
        
        print("""
            \n
            ИНФОРМАЦИЯ ОБ АВТОМОБИЛЕ \(self.make) \(self.model)
            ----------------------------------------------------------------
            МАРКА           : \(self.make)
            МОДЕЛЬ          : \(self.model)
            ГОД ВЫПУСКА     : \(self.modelYear)
            ЦВЕТ            : \(self.color.description)
            \n
            ДВИГАТЕЛЬ       : \(self.engineState.description)
            ДВЕРИ           : \(self.doorState.description)
            \n
            """)
    }
}

// 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
// 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

class SportsCar: Car {
    
    // Действия с автомобилем

    enum Action {
        case doorsUnlock
        case doorsLock
        case engineStart
        case engineStop
        
        // Уникальные действия с легковым (спортивным) автомобилем
        
        case boot
        case unboot
        
        var description: String {
            switch self {
            case .doorsLock:
                return "ЗАБЛОКИРОВАТЬ ДВЕРИ"
            case .doorsUnlock:
                return "РАЗБЛОКИРОВАТЬ ДВЕРИ"
            case .engineStart:
                return "ЗАПУСТИТЬ ДВИГАТЕЛЬ"
            case .engineStop:
                return "ЗАГЛУШИТЬ ДВИГАТЕЛЬ"
            case .boot:
                return "ЗАГРУЗИТЬ БАГАЖНИК"
            case .unboot:
                return "РАЗГРУЗИТЬ БАГАЖНИК"
            }
        }
    }
        
    // Уникальные свойства подкласса — объем багажника и заполнение багажника.
    
    var bootCapacity: Int                               // Объем багажника в дм³
    var bootLoaded: Int                                 // Заполнение багажника в дм³
    {
        didSet {
            print("БАГАЖНИК \(self.make) \(self.model) ТЕПЕРЬ ЗАГРУЖЕН НА \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%).")
        }
    }
    
    // Инициализатор
    
    init(make: String, model: String, modelYear: Int, color: Car.Color, bootCapacity: Int) {
    
        self.bootCapacity = bootCapacity
        self.bootLoaded = 0
        
        super.init(make: make, model: model, modelYear: modelYear, color: color)
                   
    }
    
    // Действия с автомобилем
    
    func performAction(action: Action, volume :Int? = nil) {
        
        print("ВЫПОЛНЯЕМ ДЕЙСТВИЕ С АВТОМОБИЛЕМ \(self.make) \(self.model): \(action.description).")
        
        switch action {
        
        case .engineStop:
            self.engineState = .off
            
        case .engineStart:
            self.engineState = .on
            
        case .doorsLock:
            self.doorState = .locked
 
        case .doorsUnlock:
            self.doorState = .unlocked
    
        // Уникальные действия
        
        case .boot:
            if let vol = volume {
            self.bootLoaded = min(self.bootLoaded + vol, self.bootCapacity)
            }
            
        case .unboot:
            if let vol = volume {
            self.bootLoaded = max(self.bootLoaded - vol, 0)
            }
        }
    }
    
    // Метод с информацией об авто
    
    override func info() {
        
        print("""
            \n
            ИНФОРМАЦИЯ О ЛЕГКОВОМ АВТОМОБИЛЕ
            --------------------------------
            МАРКА И МОДЕЛЬ  : \(self.make) \(self.model)
            ГОД ВЫПУСКА     : \(self.modelYear)
            ЦВЕТ            : \(self.color.description)
            ОБЪЕМ БАГАЖНИКА : \(self.bootCapacity) ДМ³
            ЗАГРУЖЕН НА     : \(self.bootLoaded) ДМ³ (\(self.bootLoaded * 100 / self.bootCapacity)%)
            ДВИГАТЕЛЬ       : \(self.engineState.description)
            ДВЕРИ           : \(self.doorState.description)
            \n
            """)
    }
}

class TruckCar: Car {
    
    // Действия с автомобилем

    enum Action {
        case doorsUnlock
        case doorsLock
        case engineStart
        case engineStop
        
        // Уникальные действия с грузовым автомобилем
        
        case loadCargo
        case unloadCargo
        
        var description: String {
            switch self {
            case .doorsLock:
                return "ЗАБЛОКИРОВАТЬ ДВЕРИ"
            case .doorsUnlock:
                return "РАЗБЛОКИРОВАТЬ ДВЕРИ"
            case .engineStart:
                return "ЗАПУСТИТЬ ДВИГАТЕЛЬ"
            case .engineStop:
                return "ЗАГЛУШИТЬ ДВИГАТЕЛЬ"
            case .loadCargo:
                return "ЗАГРУЗИТЬ КУЗОВ"
            case .unloadCargo:
                return "РАЗГРУЗИТЬ КУЗОВ"
            }
        }
    }
        
    // Уникальные свойства подкласса — объем кузова и заполнение кузова.
    
    var cargoCapacity: Int                               // Объем кузова в дм³
    var cargoLoaded: Int                                 // Заполнение кузова в дм³
    {
        didSet {
            print("КУЗОВ \(self.make) \(self.model) ТЕПЕРЬ ЗАГРУЖЕН НА \(self.cargoLoaded) ДМ³ (\(self.cargoLoaded * 100 / self.cargoCapacity)%).")
        }
    }
    
    // Инициализатор
    
    init(make: String, model: String, modelYear: Int, color: Car.Color, cargoCapacity: Int) {
    
        self.cargoCapacity = cargoCapacity
        self.cargoLoaded = 0
        
        super.init(make: make, model: model, modelYear: modelYear, color: color)
                   
    }
    
    // Действия с автомобилем
    
    func performAction(action: Action, volume :Int? = nil) {
        
        print("ВЫПОЛНЯЕМ ДЕЙСТВИЕ С АВТОМОБИЛЕМ \(self.make) \(self.model): \(action.description).")
        
        switch action {
        
        case .engineStop:
            self.engineState = .off

        case .engineStart:
            self.engineState = .on
      
        case .doorsLock:
            self.doorState = .locked
      
        case .doorsUnlock:
            self.doorState = .unlocked
         
        // Уникальные действия
        
        case .loadCargo:
            if let vol = volume {
            self.cargoLoaded = min(self.cargoLoaded + vol, self.cargoCapacity)
            }
            
        case .unloadCargo:
            if let vol = volume {
            self.cargoLoaded = max(self.cargoLoaded - vol, 0)
            }
        }
    }
    
    // Метод с информацией об авто
    
    override func info() {
        
        print("""
            ИНФОРМАЦИЯ О ГРУЗОВОМ АВТОМОБИЛЕ
            --------------------------------
            МАРКА И МОДЕЛЬ  : \(self.make) \(self.model)
            ГОД ВЫПУСКА     : \(self.modelYear)
            ЦВЕТ            : \(self.color.description)
            ОБЪЕМ КУЗОВА    : \(self.cargoCapacity) ДМ³
            ЗАГРУЖЕН НА     : \(self.cargoLoaded) ДМ³ (\(self.cargoLoaded * 100 / self.cargoCapacity)%)
            ДВИГАТЕЛЬ       : \(self.engineState.description)
            ДВЕРИ           : \(self.doorState.description)
            """)
    }
}

// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

var myCar1 = SportsCar(make: "LEXUS", model: "LC 500", modelYear: 2019, color: Car.Color.red, bootCapacity: 197)

myCar1.performAction(action: SportsCar.Action.boot, volume: 100)
myCar1.performAction(action: SportsCar.Action.unboot, volume: 50)

myCar1.performAction(action: SportsCar.Action.engineStart)
myCar1.performAction(action: SportsCar.Action.engineStop)

myCar1.performAction(action: SportsCar.Action.doorsUnlock)
myCar1.performAction(action: SportsCar.Action.doorsLock)

var myCar2 = TruckCar(make: "CHEVROLET", model: "SILVERADO", modelYear: 2021, color: Car.Color.silver, cargoCapacity: 1784)

myCar2.performAction(action: TruckCar.Action.loadCargo, volume: 1700)
myCar2.performAction(action: TruckCar.Action.unloadCargo, volume: 1650)

myCar2.performAction(action: TruckCar.Action.engineStart)
myCar2.performAction(action: TruckCar.Action.doorsUnlock)

// 6. Вывести значения свойств экземпляров в консоль.

myCar1.info()
myCar2.info()
