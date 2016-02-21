//
//  ViewController.m
//  Geocode
//
//  Created by Archy on 15/6/16.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
/**
 *  监听地理编码点击事件
 */
- (IBAction)geocodeBtnClick;
/**
 *  需要编码的地址容器
 */
@property (weak, nonatomic) IBOutlet UITextField *addressField;
/**
 *  经度容器
 */
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
/**
 *  纬度容器
 */
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
/**
 *  详情容器
 */
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;
/**
 *  地理编码对象
 */
@property (nonatomic ,strong) CLGeocoder *geocoder;
@end

@implementation ViewController

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)geocodeBtnClick
{
    NSString *addressStr = self.addressField.text;
    //判断你是否输入地址
    if (addressStr == nil || addressStr.length == 0) {
        NSLog(@"请输入地址");
        return;
    }
    //对地理编码进行解析
    [self.geocoder geocodeAddressString:addressStr completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (placemarks.count == 0 || error != nil) {
            return ;
        }
        //位置信息
        CLPlacemark *placeMark = [placemarks firstObject];
        
        self.latitudeLabel.text = [NSString stringWithFormat:@"%f", placeMark.location.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"%f", placeMark.location.coordinate.longitude];
        NSArray *address = placeMark.addressDictionary[@"FormattesAddresslines"];
        NSMutableString *strM = [NSMutableString string];
        for (NSString *str in address) {
            [strM appendString:str];
        }
        
        self.detailAddressLabel.text = strM;
    }];
}

@end
