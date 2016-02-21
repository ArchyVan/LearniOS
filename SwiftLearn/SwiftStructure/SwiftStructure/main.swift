//
//  main.swift
//  SwiftStructure
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation

println("Hello, World!")

struct Test {
    var x = 0
    var y = 0
    init() {
        println("in init")
    }
    init(x:Int, y:Int)
    {
        self.x = x
        self.y = y
        NSLog("in init(x: y:)")
    }
    init(_ x:Int ,_ y:Int) {
        self.x = x
        self.y = y
    }
    func getCenter() ->Int {
        return (x+y)/2
    }
    mutating func addOffset(deltaX:Int,deltaY:Int) {
        x += deltaX
        y += deltaY
    }
}

func testStructure() {
    
    var s = Test(x: 100, y: 100)
    println("s.x = \(s.x)")
    
    var s2 = Test(333,444)
    
    let center = s2.getCenter()
    
    s2.addOffset(100, deltaY: 200)
    
}