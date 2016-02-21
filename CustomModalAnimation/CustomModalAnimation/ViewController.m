//
//  ViewController.m
//  06-自定义Modal动画
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ViewController.h"
#import "HMSecondViewController.h"
#import "HMTransition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 屏幕适配

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    HMSecondViewController *second = [[HMSecondViewController alloc] init];
    second.view.backgroundColor = [UIColor redColor];
    second.modalPresentationStyle = UIModalPresentationCustom;
    second.transitioningDelegate = [HMTransition sharedtransition];
    [self presentViewController:second animated:YES completion:nil];
}

- (IBAction)itemClick:(id)sender {
//    UIViewController *three = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"three"];
//    three.modalPresentationStyle = UIModalPresentationCustom;
//    three.transitioningDelegate = [HMTransition sharedtransition];
//    [self presentViewController:three animated:YES completion:nil];
}

@end
