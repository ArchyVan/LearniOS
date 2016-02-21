//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//func sum(num1:Int ,num2: Int) ->Int
//{
//    return num1 + num2
//}


func minus(num1:Int , num2:Int) -> Int
{
    return num1 - num2
}

func printResult(fn:(Int,Int)->Int,num1:Int,num2:Int)
{
    println(fn(num1,num2))
}

var c = printResult(minus , 100, 50)


func howToDo(day:Int)-> Void->Void
{
    func goToWork(){
        println("Go Work")
    }
    func haveFun(){
        println("Go Play")
    }
    
    if day == 6 || day == 7 {
        return haveFun
    } else {
        return goToWork
    }
}

var fn = howToDo(3)
fn()

