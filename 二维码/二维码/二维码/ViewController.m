//
//  ViewController.m
//  二维码
//
//  Created by Archy on 15/6/21.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    image.image = [self createfilter];
    [self.view addSubview:image];
}

- (UIImage *)createfilter
{
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data = [@"I LOVE YOU" dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    // 6.得到二维码图片
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    
    return image;
}

@end
