//
//  main.swift
//  SwiftControlStatement
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation

println("Hello, World!")

var score = 80
var scoreArr = [90,100,23,43,43,67]

var minScore = 0
var maxScore = 0
var avgScore = 0.0
var sumScore = 0.0
var count = scoreArr.count


for s in scoreArr {
    sumScore = sumScore + Double(s);
    println("sumScore is \(sumScore)");
    println("s is \(s)");
    if (minScore == 0 || minScore > s)
    {
        minScore = s
    }
    if (maxScore == 0 || maxScore < s)
    {
        maxScore = s
    }
}
avgScore = sumScore / Double(count)
println("sumScore is \(sumScore)")
println("avgScore is \(avgScore)")
println("minScore is \(minScore)")
println("maxScore is \(maxScore)")

for var i = 0;i < count;i++ {
    var s = scoreArr[i]
    println("s is \(s)")
}


var index = 0;
do {
    
    if (index >= count){
        break;
    }
    var s = scoreArr[index]
    println("do - while s[\(index)]= \(s)")
    
} while (++index < count)



let appType = "iOS"
switch appType {
case "iOS":
    println("iOS开发")
    fallthrough
case "Android":
    println("Android开发")
    fallthrough
case "wPhone":
    println("windows phone")
    fallthrough
default:
    println("None")
}