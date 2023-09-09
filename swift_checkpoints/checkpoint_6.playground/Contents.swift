import Cocoa

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear = 1
    
    init (model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func changeGearUp() -> Bool {
        if currentGear == 10 {
            return false
        }
        
        currentGear += 1
        return true
    }
    
    mutating func changeGearDown() -> Bool {
        if currentGear == 1 {
            return false
        }
        
        currentGear -= 1
        return true
    }
}

var car = Car(model: "Honda 1999", numberOfSeats: 4)

var success = car.changeGearUp()
car

success = car.changeGearDown()
success = car.changeGearDown()
car
