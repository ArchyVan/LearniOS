//
//  ViewController.m
//  SystemShare
//
//  Created by Archy on 15/6/18.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //询问系统能否使用分享
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"分享服务不可用");
    }
    
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    [composeVc setInitialText:@"分享的内容"];
    [composeVc addImage:[UIImage imageNamed:@"分享的图片"]];
    
    [self presentViewController:composeVc animated:YES completion:nil];
    
    composeVc.completionHandler = ^(SLComposeViewControllerResult result)
    {
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"取消发送");
        } else {
            NSLog(@"发送成功");
        }
    };
}
@end
