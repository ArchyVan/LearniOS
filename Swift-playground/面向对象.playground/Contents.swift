//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//
//class Person {
//    var age: Int = 1{
//        willSet{
//        
//        }
//        didSet{
//        
//        }
//    }
//    var name : String {
//        get{
//            return "Jack"
//        }
//        set{
//        
//        }
//    }
//}
//var p = Person()
//p.age = 3
//p.name = "Rose"
//
//println("p.name=\(p.name)")


class Animal {
    var speed:Int = 100{
        willSet{
        
        }
        didSet{
        
        }
    }
}

class Dog:Animal {
    override var speed:Int{
        willSet{
        
        }
        didSet{
        
        }
    }
}

var a = Animal()
a.speed = 10

var d = Dog()
d.speed = 100

