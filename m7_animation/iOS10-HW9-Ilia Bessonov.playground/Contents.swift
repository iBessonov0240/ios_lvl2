import UIKit

enum EngineType {
    case diesel
    case petrol
    case electric
}

protocol Car {
    var model: String { get }
    var brand: String { get set }
    var year: Int { get }
    var price: Int { get set }
    var engineType: EngineType { get }

    func startEngine()
}

protocol SpecialOffer {
    var currentYear: Int { get }

    func addEmergencyPack()
    func makeSpecialOffer(_ brand: Car)
}

protocol Dealership {
    var name: String { get }
    var showroomCapacity: Int { get }
    var stockCars: [Car] { get set }
    var showroomCars: [Car] { get set }
    var cars: [Car] { get set }
    var slogan: String { get }

    func offerAccesories(_ accessories: [String])
    func presaleService(_ car: Car)
    func addToShowroom(_ name: Car)
    func sellCar(_ name: Car)
    func orderCar()
}

class Porsche: Car {
    var brand = "Porsche"
    var engineType: EngineType
    var model: String
    var year: Int
    var price: Int

    init(model: String, engineType: EngineType, year: Int, price: Int) {
        self.model = model
        self.engineType = engineType
        self.year = year
        self.price = price
    }

    func startEngine() {
        print("I'm \(brand) \(model). My \(engineType) engine was started.")
    }
}

class Audi: Car {
    var brand = "Audi"
    var engineType: EngineType
    var model: String
    var year: Int
    var price: Int

    init(model: String, engineType: EngineType, year: Int, price: Int) {
        self.model = model
        self.engineType = engineType
        self.year = year
        self.price = price
    }

    func startEngine() {
        print("I'm \(brand) \(model). My \(engineType) engine was started.")
    }
}

class Mersedes: Car {
    var brand = "Mersedes"
    var engineType: EngineType
    var model: String
    var year: Int
    var price: Int

    init(model: String, engineType: EngineType, year: Int, price: Int) {
        self.model = model
        self.engineType = engineType
        self.year = year
        self.price = price
    }

    func startEngine() {
        print("I'm \(brand) \(model). My \(engineType) engine was started.")
    }
}

class PorscheDealer: Dealership {
    var currentYear = 2023
    var name = "PorscheCenter"
    var showroomCapacity: Int
    var stockCars: [Car]
    var showroomCars: [Car]
    var cars: [Car]
    lazy var presaleCars: [Car] = showroomCars
    var equipment = [String]()
    var accesories = ["коврики", "елочку", "собачку на приборку"]
    var slogan = "There is no substitute"

    init(showroomCapacity: Int, stockCars: [Car], showroomCars: [Car], cars: [Car]) {
        self.showroomCapacity = showroomCapacity
        self.stockCars = stockCars
        self.showroomCars = showroomCars
        self.cars = cars
    }

    func offerAccesories(_ accessories: [String]) {
        print("В салоне Порше мы можем предложить следующие акксесуары:")
        for accessory in accessories {
            print("- \(accessory)")
        }
    }

    func presaleService(_ car: Car) {
        presaleCars.append(car)
        print("\(car.model) прошла предпродажную подготовку")
    }

    func addToShowroom(_ name: Car) {
        guard let index = stockCars.firstIndex(where: { $0.model == name.model }) else { return }
            let car = stockCars.remove(at: index)
            showroomCars.append(car)
            presaleCars.append(name)
        print("перегнали машину с парковки склада в автосалон, при этом выполнели предпродажную подготовку")
    }

    func sellCar(_ name: Car) {
        if presaleCars.contains(where: { $0.model == name.model }) {
            if !equipment.isEmpty {
                print("Купите доп. оборудование")
                self.equipment.append("Аптечка")
                self.equipment.append("Огнетушитель")
            }
            print("машина продана")
        }
    }

    func orderCar() {
        let newCar = Porsche(model: "Panamera", engineType: .petrol, year: 2022, price: 30000)
        stockCars.append(newCar)
        print("Новый порше доставлен с завода")
    }
}

class AudiDealer: Dealership {
    var currentYear = 2023
    var name = "AudiCenter"
    var showroomCapacity: Int
    var stockCars: [Car]
    var showroomCars: [Car]
    var cars: [Car]
    lazy var presaleCars: [Car] = showroomCars
    var equipment = [String]()
    var accesories = ["коврики", "елочку", "собачку на приборку"]
    var slogan = "Vorsprung durch Technik"

    init(showroomCapacity: Int, stockCars: [Car], showroomCars: [Car], cars: [Car]) {
        self.showroomCapacity = showroomCapacity
        self.stockCars = stockCars
        self.showroomCars = showroomCars
        self.cars = cars
    }

    func offerAccesories(_ accessories: [String]) {
        print("В салоне Ауди мы можем предложить следующие акксесуары:")
        for accessory in accessories {
            print("- \(accessory)")
        }
    }

    func presaleService(_ car: Car) {
        presaleCars.append(car)
        print("\(car.model) прошла предпродажную подготовку")
    }

    func addToShowroom(_ name: Car) {
        guard let index = stockCars.firstIndex(where: { $0.model == name.model }) else { return }
            let car = stockCars.remove(at: index)
            showroomCars.append(car)
            presaleCars.append(name)
        print("перегнали машину с парковки склада в автосалон, при этом выполнели предпродажную подготовку")
    }

    func sellCar(_ name: Car) {
        if presaleCars.contains(where: { $0.model == name.model }) {
            if !equipment.isEmpty {
                print("Купите доп. оборудование")
                self.equipment.append("Аптечка")
                self.equipment.append("Огнетушитель")
            }
            print("машина продана")
        }
    }

    func orderCar() {
        let newCar = Audi(model: "Q8", engineType: .petrol, year: 2021, price: 18400)
        stockCars.append(newCar)
        print("Новый ауди доставлен с завода")
    }
}

class MersedesDealer: Dealership {
    var currentYear = 2023
    var name = "MersedesDealer"
    var showroomCapacity: Int
    var stockCars: [Car]
    var showroomCars: [Car]
    var cars: [Car]
    lazy var presaleCars: [Car] = showroomCars
    var equipment = [String]()
    var accesories = ["коврики", "елочку", "собачку на приборку"]
    var slogan = "Das Beste oder nichts"

    init(showroomCapacity: Int, stockCars: [Car], showroomCars: [Car], cars: [Car]) {
        self.showroomCapacity = showroomCapacity
        self.stockCars = stockCars
        self.showroomCars = showroomCars
        self.cars = cars
    }

    func offerAccesories(_ accessories: [String]) {
        print("В салоне Мерседес мы можем предложить следующие акксесуары:")
        for accessory in accessories {
            print("- \(accessory)")
        }
    }

    func presaleService(_ car: Car) {
        presaleCars.append(car)
        print("\(car.model) прошла предпродажную подготовку")
    }

    func addToShowroom(_ name: Car) {
        guard let index = stockCars.firstIndex(where: { $0.model == name.model }) else { return }
            let car = stockCars.remove(at: index)
            showroomCars.append(car)
            presaleCars.append(name)
        print("перегнали машину с парковки склада в автосалон, при этом выполнели предпродажную подготовку")
    }

    func sellCar(_ name: Car) {
        if presaleCars.contains(where: { $0.model == name.model }) {
            if !equipment.isEmpty {
                print("Купите доп. оборудование")
                self.equipment.append("Аптечка")
                self.equipment.append("Огнетушитель")
            }
            print("машина продана")
        }
    }

    func orderCar() {
        let newCar = Mersedes(model: "G63", engineType: .petrol, year: 2023, price: 35400)
        stockCars.append(newCar)
        print("Новый мерседес доставлен с завода")
    }
}

// Часть 3
let panamera = Porsche(model: "Panamera", engineType: .petrol, year: 2022, price: 30000)
let cayenne = Porsche(model: "Cayenne", engineType: .diesel, year: 2023, price: 15000)
let nineNineOne = Porsche(model: "911", engineType: .petrol, year: 2021, price: 25000)

let eTron = Audi(model: "e-tron", engineType: .electric, year: 2023, price: 29800)
let qEight = Audi(model: "Q8", engineType: .petrol, year: 2021, price: 18400)
let rsSix = Audi(model: "RS6", engineType: .petrol, year: 2022, price: 32250)

let gClass = Mersedes(model: "G63", engineType: .petrol, year: 2023, price: 35400)
let eQS = Mersedes(model: "EQS", engineType: .electric, year: 2022, price: 27400)
let eSixThree = Mersedes(model: "E63s", engineType: .petrol, year: 2021, price: 26700)

let porscheDealer = PorscheDealer(showroomCapacity: 12, stockCars: [panamera, cayenne, nineNineOne, panamera, cayenne, nineNineOne, panamera, cayenne, nineNineOne], showroomCars: [panamera, nineNineOne], cars: [])
let audiDealer = AudiDealer(showroomCapacity: 13, stockCars: [eTron, qEight, rsSix, eTron, qEight, rsSix, eTron, qEight, rsSix, eTron, qEight, rsSix], showroomCars: [eTron, rsSix], cars: [])
let mersedesDealer = MersedesDealer(showroomCapacity: 15, stockCars: [gClass, eQS, eSixThree, gClass, eQS, eSixThree, gClass, eQS, eSixThree, gClass, eQS, eSixThree], showroomCars: [gClass, eSixThree], cars: [])

// все диллерские центры
let allDealers: [Dealership] = [porscheDealer, audiDealer, mersedesDealer]
allDealers.forEach { dealerSlogan in
    print("\(dealerSlogan.name): \(dealerSlogan.slogan)")
}

// Часть 4
extension PorscheDealer: SpecialOffer {
    func addEmergencyPack() {
        self.equipment.append("Аптечка")
        self.equipment.append("Огнетушитель")
    }

    func makeSpecialOffer(_ brand: Car) {
        if brand.year < 2023 {
            var car = brand
            let discont = Double(car.price) * 0.15
            car.price -= Int(discont)
            addEmergencyPack()
        }
    }
}

extension AudiDealer: SpecialOffer {
    func addEmergencyPack() {
        self.equipment.append("Аптечка")
        self.equipment.append("Огнетушитель")
    }

    func makeSpecialOffer(_ brand: Car) {
        if brand.year < 2023 {
            var car = brand
            let discont = Double(car.price) * 0.15
            car.price -= Int(discont)
            addEmergencyPack()
        }
    }
}

extension MersedesDealer: SpecialOffer {
    func addEmergencyPack() {
        self.equipment.append("Аптечка")
        self.equipment.append("Огнетушитель")
    }

    func makeSpecialOffer(_ brand: Car) {
        if brand.year < 2023 {
            var car = brand
            let discont = Double(car.price) * 0.15
            car.price -= Int(discont)
            addEmergencyPack()
        }
    }
}

// проверяем машины в салоне и делаем скидку
for i in 0..<porscheDealer.showroomCars.count {
    if porscheDealer.showroomCars[i].year < 2023 {
        porscheDealer.makeSpecialOffer(porscheDealer.showroomCars[i])
    }
}

for i in 0..<audiDealer.showroomCars.count {
    if audiDealer.showroomCars[i].year < 2023 {
        audiDealer.makeSpecialOffer(audiDealer.showroomCars[i])
    }
}

for i in 0..<mersedesDealer.showroomCars.count {
    if mersedesDealer.showroomCars[i].year < 2023 {
        mersedesDealer.makeSpecialOffer(mersedesDealer.showroomCars[i])
    }
}

// проверяем машины на складе и перегоняем в автосалон
for i in (0..<porscheDealer.stockCars.count).reversed() {
    if porscheDealer.stockCars[i].year < 2023 {
        porscheDealer.makeSpecialOffer(porscheDealer.stockCars[i])
        porscheDealer.showroomCars.append(porscheDealer.stockCars[i])
        porscheDealer.stockCars.remove(at: i)
    }
}

for i in (0..<audiDealer.stockCars.count).reversed() {
    if audiDealer.stockCars[i].year < 2023 {
        audiDealer.makeSpecialOffer(audiDealer.stockCars[i])
        audiDealer.showroomCars.append(audiDealer.stockCars[i])
        audiDealer.stockCars.remove(at: i)
    }
}

for i in (0..<mersedesDealer.stockCars.count).reversed() {
    if mersedesDealer.stockCars[i].year < 2023 {
        mersedesDealer.makeSpecialOffer(mersedesDealer.stockCars[i])
        mersedesDealer.showroomCars.append(mersedesDealer.stockCars[i])
        mersedesDealer.stockCars.remove(at: i)
    }
}

// все методы Порше
porscheDealer.offerAccesories(porscheDealer.accesories)
porscheDealer.presaleService(porscheDealer.stockCars.first!)
porscheDealer.addToShowroom(porscheDealer.stockCars.first!)
porscheDealer.sellCar(porscheDealer.showroomCars.first!)
porscheDealer.orderCar()

// все методы Ауди
audiDealer.offerAccesories(audiDealer.accesories)
audiDealer.presaleService(audiDealer.stockCars.first!)
audiDealer.addToShowroom(audiDealer.stockCars.first!)
audiDealer.sellCar(audiDealer.showroomCars.first!)
audiDealer.orderCar()

// все методы Мерседес
mersedesDealer.offerAccesories(mersedesDealer.accesories)
mersedesDealer.presaleService(mersedesDealer.stockCars.first!)
mersedesDealer.addToShowroom(mersedesDealer.stockCars.first!)
mersedesDealer.sellCar(mersedesDealer.showroomCars.first!)
mersedesDealer.orderCar()
