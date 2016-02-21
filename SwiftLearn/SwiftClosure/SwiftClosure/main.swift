//
//  main.swift
//  SwiftClosure
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation

println("Hello, World!")

//Closure 类似于 Block

func hasClosureMatch(arr : Int[] ,value : Int,cb:(num:Int)->Bool
    ) ->Bool
{
    for item in arr
    {
        if (cb(num:item))
        {
            return true
        }
    }
    return false
}

var arr = [20, 9, 100, 34, 89, 39]

var v1 = hasClosureMatch(arr ,40 ,{
//    (num: Int) -> Bool in
//    return num >= 40;
    return $0 >= 40;
})

println("v1 is \(v1)")

