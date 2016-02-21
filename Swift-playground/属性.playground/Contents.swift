//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//class Dog {
//    var name:String = "xiaohei"
//    init(){
//        println("Dog--init")
//    }
//}
//
//class Person {
//    var age:Int = 1
//    var height : Double = 1.5
//    let life = 1
//    lazy var dog : Dog = Dog()
//}
//
//var p = Person()
//
//p.dog
//p.age = 20
//p.height = 1.8
//p.life



//class Square {
//    
//    var width: Double = 0
//    
//    var girth: Double {
//        get{
////            return girth -- Error
//            return width * 4
//        }
//        set{
//            girth = newValue
//        }
//    }
//    
//}
//
//var s = Square()
//s.width = 10
//s.girth


//class Square {
//    
//    var girth :Double {
//        get{
//            return 40
//        }
//    }
//    
////    var girth : Double {
////        return 40
////    }
//    var width : Double = 0.0
//}
//
//var s = Square()
//s.width = 100


//class Circle {
//    class var PI: Double{
//        return 3.14
//    }
//}
//
//var c1 = Circle()
//Circle.PI


//class Square {
//    
//    var width: Double = 0.0{
//        willSet(newWidth){
//            println("newWidth \(newWidth)")
//        }
//        didSet(oldWidth){
//            println("oldWidth \(oldWidth)")
//        }
//    }
//    
//    var girth : Double {
//        get{
//            return width * 4
//        }
//        set{
//            width = newValue / 4
//        }
//    }
//}
//
//var s = Square()
//s.width = 10.0


class Square {
    var width : Double = 0.0{
        willSet{
        
        }
        didSet{
            width = 80
        }
    }
}

var s = Square()

s.width = 40

println("width=\(s.width)")