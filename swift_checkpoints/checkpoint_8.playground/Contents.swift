import Cocoa

protocol Building {
    var numOfRooms: Int { get }
    var cost: Int { get set }
    var agentName: String { get set }
    func summary()
}

struct House: Building {
    var numOfRooms: Int
    var cost: Int
    var agentName: String
    func summary() {
        print("House summary:\nRooms \(numOfRooms)\nCost \(cost)\nAgent \(agentName)")
    }
}

struct Office: Building {
    var numOfRooms: Int
    var cost: Int
    var agentName: String
    func summary() {
        print("Office summary:\nRooms \(numOfRooms)\nCost \(cost)\nAgent \(agentName)")
    }
}

let house = House(numOfRooms: 5, cost: 25000, agentName: "Victor")
house.summary()

let office = Office(numOfRooms: 50, cost: 100000, agentName: "Din")
office.summary()
