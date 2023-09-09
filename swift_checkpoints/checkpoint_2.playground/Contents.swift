import Cocoa

let names: Array<String> = ["Tom", "Joe", "Max", "Joe", "Billy"]

print(names.count)

let uniqueNames = Set(names)

print(uniqueNames.count)
