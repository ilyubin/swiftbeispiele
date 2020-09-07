import UIKit

var str = "Hello, playground"

class MyClass {
    var x: Int = 10 {
        didSet {
            print("didSet \(oldValue) \(x)")
        }
        willSet {
            print("willSet \(x) \(newValue)")
        }
    }
}

let c = MyClass()
c.x = 1
c.x = 2
