
//
//  FunctionTest.swift
//  LearnSwift
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation

func testContact2(v1:String, andValue v2:String , andNumber v3:Int) ->String
{
    return "\(v1) and \(v2) and \(v3)"
}

func getInfo() -> (String, String, String)
{
    return ("QF","iOS","Swift Video")
}

func testFunctionInFunction() -> Int
{
    var y : Int = 10
    func add() {
        y += 5
    }
    add()
    return y
}

func testFunction() {
    println("Start Test")
    
    let v2 = testContact2("QF", andValue:"Swift",andNumber:100)
    println("v2 is \(v2)")
    
    let (v3, v4, v5) = getInfo()
    println("v3=\(v3) v4=\(v4) v5=\(v5)")
    
        var arr = [20, 100, 390, 30 ,43, 33]
    var v8 = hasAnyMatch(arr, lessThanTen)
    println("v8 is \(v8)")
    
}
func hasAnyMatch(list : Int[], condition:Int->Bool) ->Bool
{
    for item in list {
        if (condition(item))
        {
            return true;
        }
    }
    return false
}
func lessThanTen(number: Int) ->Bool
{
    return number <= 10;
}
