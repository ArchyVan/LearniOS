//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//class Calculator {
//    
//    var price: Double = 10.0
//    
//    class func sum(num1:Int,num2:Int) -> Int
//    {
//        self
//        return num1 + num2
//    }
//    
//    func sum (num1:Int,num2:Int) ->Int
//    {
//        self
//        return num1 + num2
//    }
//    
//}
//
//Calculator.sum(20, num2: 20)
//
//var c = Calculator()
//c.sum(10, num2: 20)
//
//var c2 = Calculator()
//c2.sum(10, num2: 20)
//
//
//c.sum(cal_num1:10, num2: 20)


class Person {
    class func run() {
        println("class func run")
    }
    
    func run(){
        println("func run")
    }
    class func test()
    {
        run()
    }
    func test()
    {
        self.run()
    }
}
