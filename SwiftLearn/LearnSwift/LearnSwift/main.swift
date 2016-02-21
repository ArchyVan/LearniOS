//
//  main.swift
//  LearnSwift
//
//  Created by Archy on 15/6/15.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation
print("Hello, World!")

func sum(num1: Int, num2: Int) ->Int
{
    return num1 + num2
}

func minus(num1: Int, num2: Int) ->Int
{
    return num1 - num2
}

func divide(num1: Int, num2: Int) ->Int
{
    return num1 / num2
}


var c = sum(10, num2: 20)
print(c)


func printResult(fn:(Int, Int)->Int,num1:Int,num2:Int)
{
    print(fn(num1,num2))
}

printResult(sum, num1: 10, num2: 22)


func printLine()
{
    print("-------")
}

printLine()


func howToDo(day:Int) ->Void ->Void
{
    func goToWork(){
        print("上班去。。。。")
    }
    func haveFun(){
        print("踢足球。。。。")
    }
    
    if day == 6 || day == 7 {
        return haveFun
    } else {
        return goToWork
    }
}

var fn = howToDo(5)
fn()



func addStudent(name:String, age:NSInteger){
//    assert(age > 0, "年龄参数不正确")
    print("添加了一个学生：姓名=\(name)，年龄=\(age)")

}

addStudent("Jack", age: 20)
addStudent("Jake", age: -10)
addStudent("Rose", age: 22)


func sum(num1: Int,num2:Int,num3:Int)->Int
{
    return num1 + num2 + num3
}

var a:Int = sum(10, num2: 20, num3: 30)
print(a)



var 国家 = "中国"
print("国家是\(国家)")



testFunction()

