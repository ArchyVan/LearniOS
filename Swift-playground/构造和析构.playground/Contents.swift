//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//class Dog {
//    var name: String
//    var age: Int
//    init(_ name: String, _ age:Int)
//    {
//        self.name = name
//        self.age = age
//    }
//}
//
//var d = Dog("wangcai",10)


// 只有便利构造方法才能直接调用当前类的其他构造方法
// 只有指定构造方法才能直接调用父类的构造方法

/*
class Dog {
var speed: Double
var name: String
var age: Int

init(name : String, age : Int, speed: Double) {
self.name = name
self.age = age
self.speed = speed
}

convenience init(name : String) {
self.init(name: name, age: 1, speed: 0.0)
}

convenience init(age : Int) {
self.init(name: "", age: age, speed: 0.0)
}

convenience init(speed : Double) {
self.init(name: "", age: 1, speed: speed)
}
}
*/

//var d1 = Dog()

//println("name=\(d1.name), age=\(d1.age)")

//var d2 = Dog(name: "jack", age: 2)
//println("name=\(d2.name), age=\(d2.age)")

// 存储属性：只能由父类先初始化，再由子类初始化

/*
class Animal {
    var age: Int
    let life: Int

    init()  {
        self.age = 1
        self.life = 1
        }
}

class Dog : Animal {
        init()  {
            super.init()
            self.age = 20
            self.life = 2
        }
}

var d = Dog()
println(d.age)*/

/*
class Dog {
    deinit {
        println("Dog---死了")
    }
}

func newDog()
{
var d = Dog()
}

println("newDog---0")
newDog()
println("newDog---1")
*/

//class Dog : Animal {
//    init()  {
//        super.init()
//        println("Dog-init")
//    }
//}

class Animal {
    var age : Int
    init() {
        self.age = 1
    }
}
class Dog : Animal {
    
    override init()  {
        super.init()
        self.age = 2
    }
}