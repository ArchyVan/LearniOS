//
//  ViewController.m
//  05-桥接
//
//  Created by apple on 14/11/11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Foundation 和 Core  Foundation 相互转换. 桥接
    // 以后在使用C语言的函数时, 只要函数名称包含creat/copy/retain 就必须自己手动释放CFRelease
    // MRC 非ARC
    // 在非ARC情况下, 如果想将Foundation转换为Core  Foundation , 直接强制类型转换即可
    /*
        NSString *strOC = [NSString stringWithFormat:@"往年附加快递费"];
        CFStringRef strC = (CFStringRef)strOC;
        NSLog(@"%@ %@", strOC, strC);
     */
    
    // 在非ARC情况下, 如果想将Core Foundation转换为Foundation , 直接强制类型转换即可
    /*
        CFStringRef strC = CFStringCreateWithCString(CFAllocatorGetDefault(), "12345678", kCFStringEncodingASCII);
        NSString *strOC = ( NSString *)strC;
        NSLog(@"%@ %@", strOC, strC);
     */
    
    
    // ARC  __bridge / __bridge_retained / __bridge_transfer
   /*
    NSString *strOC = [NSString stringWithFormat:@"abcdefg"];
    // 如果使用__bridge桥接, 它仅仅是将strOC的地址给了strC, 并没有转移对象的所有权
    // 也就是说, 如果使用__bridge桥接, 那么如果strOC释放了,strC也不能用了
    // 注意: 在ARC条件下, 如果是使用__bridge桥接, 那么strC可以不用释放, 应为ARC会自动管理strOC的内容
    CFStringRef strC = (__bridge CFStringRef)strOC;
    NSLog(@"%@ %@", strOC, strC);
    */
    
    /*
     NSString *strOC = [NSString stringWithFormat:@"abcdefg"];
    // 如果使用__bridge_retained桥接, 它会将对象的所有权转移给strC, 也就是说, 即便strOC被释放了, strC也可以使用
    // 注意: 在ARC条件下,如果是使用__bridge_retained桥接, 那么strC必须自己手动释放, 因为桥接的时候已经将对象的所有权转移给了strC, 而C语言的东西不是不归ARC管理的
//    CFStringRef strC = (__bridge_retained CFStringRef)strOC;
    CFStringRef strC = CFBridgingRetain(strOC);// 这一句, 就等同于上一句
    CFRelease(strC);
     */

    
   /*
     CFStringRef strC = CFStringCreateWithCString(CFAllocatorGetDefault(), "12345678", kCFStringEncodingASCII);
    // 如果使用__bridge桥接, 它仅仅是将strC的地址给了strOC, 并没有转移对象的所有权
    // 也就是说如果使用__bridge桥接, 那么如果strC释放了,strOC也不能用了
//    NSString *strOC = (__bridge NSString *)strC;
   */

    /*
     CFStringRef strC = CFStringCreateWithCString(CFAllocatorGetDefault(), "12345678", kCFStringEncodingASCII);
     // 如果使用__bridge_transfer桥接, 它会将对象的所有权转移给strOC, 也就是说, 即便strC被释放了, strOC也可以使用
    // 如果使用__bridge_transfer桥接, 他会自动释放strC, 也就是以后我们不用手动释放strC
//     NSString *strOC = (__bridge_transfer NSString *)strC;
      NSString *strOC = CFBridgingRelease(strC); // 这一句, 就等同于上一句
     */
}



@end
