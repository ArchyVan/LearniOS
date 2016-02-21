//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


func sum(num1: Int,num2:Int) ->Int
{
    return num1 + num2 + 10
}

func sum(num1:Int,num2:Int) -> Double
{
    return Double(num1) + Double(num2) + 2
}


var a: Int = sum(10, 20)
var b: Double = sum(10, 20)