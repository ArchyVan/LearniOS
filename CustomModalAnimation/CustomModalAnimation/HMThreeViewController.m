//
//  HMThreeViewController.m
//  06-自定义Modal动画
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMThreeViewController.h"
#import "HMTransition.h"

@interface HMThreeViewController ()

@end

@implementation HMThreeViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = [HMTransition sharedtransition];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
