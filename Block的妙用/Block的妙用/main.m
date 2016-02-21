//
//  main.m
//  Block的妙用
//
//  Created by Archy on 15/6/11.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *per = [[Person alloc] init];
        
        per.study(@"Math").run().study(@"Chinese");
        
    }
    return 0;
}
