import Cocoa

func randomInt(from array: [Int]?) -> Int { array?.randomElement() ?? Int.random(in: 1...100) }

let numbers = [1, 2, 3, 4, 5]
let number1 = randomInt(from: numbers)

let numbersNil: [Int]? = nil
let number2 = randomInt(from: numbersNil)
