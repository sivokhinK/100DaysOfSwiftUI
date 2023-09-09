import Cocoa

enum SqrtErrors : Error {
    case tooLow
    case tooHigh
    case noRoot
}

func Sqrt(_ x: Int) throws -> Int {
    if x < 1 { throw SqrtErrors.tooLow }
    if x > 10000 { throw SqrtErrors.tooHigh }
    
    var squared = 0
    var root = 0
    while squared < x {
        root += 1
        squared = root * root
    }
    
    if squared != x {
        throw SqrtErrors.noRoot
    }
    else {
        return root
    }
}

do {
    let result = try Sqrt(25)
} catch SqrtErrors.tooLow {
    print("Too low error")
} catch SqrtErrors.tooHigh {
    print("Too high error")
} catch {
    print("No root")
}
