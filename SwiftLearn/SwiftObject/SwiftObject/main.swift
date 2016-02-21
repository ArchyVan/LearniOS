//
//  main.swift
//  SwiftObject
//
//  Created by Archy on 15/6/22.
//  Copyright (c) 2015年 Van. All rights reserved.
//

import Foundation

print("Hello, World!")


class Person {
    
    var age: Int = 0
    var name: String?

    init() {
        self.age = 5
        name = "xiaogang"
    }
    init(name:String , age:Int)
    {
        self.age = age
        self.name = name
    }
    deinit {
        
    }
    func getAge() ->Int{
        return age
    }
    func getName() ->String{
        return name!
    }
    class func MaxAge() -> Int {
        return 200
    }
    class func person() ->Person {
        return Person()
    }
}

func testClass(){

    let xiaoming = Person()
    xiaoming.age = 100;
    
    print("xiaoming: \(xiaoming)")
    
    let maxAge = Person.MaxAge()
    
    print("max age is \(maxAge)")
    
    var xiaowang = Person(name: "小王", age: 10)
    
}
testClass();
