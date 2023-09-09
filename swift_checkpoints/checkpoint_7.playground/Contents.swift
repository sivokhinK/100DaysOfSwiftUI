import Cocoa

class Animal {
    var legs = 4
    
    init () { }
    
    init (numOfLegs: Int) {
        legs = numOfLegs
    }
}

class Dog: Animal {
    func speak() {
        print("Bark Bark")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Corgi speaking!!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Poodle speaking!!")
    }
}

class Cat: Animal {
    var isTame = false
    
    override init() {
        super.init()
    }
    
    init(numOfLegs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(numOfLegs: numOfLegs)
    }
    
    func speak() {
        print("Cat speaking")
    }
}

class Persian: Cat {
    override func speak() {
        print("Persian speaking")
    }
}

class Lion: Cat {
    override func speak() {
        print("Lion speaking")
    }
}

var persian = Persian()
var lion = Lion(numOfLegs: 7, isTame: true)
persian.speak()
lion.speak()
