//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



func addStudent(name:String,age:Int)
{
    assert(age > 0, "Age Is Error")
    
    println("Add a Student :\(name),\(age)")
}

addStudent("Rose", 20)
addStudent("Jack", -10)
addStudent("Joker", 10)

