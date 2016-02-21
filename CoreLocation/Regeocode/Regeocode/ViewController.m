//
//  ViewController.m
//  Regeocode
//
//  Created by Archy on 15/6/16.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

/**
 *  地理编码对象
 */
@property (nonatomic ,strong) CLGeocoder *geocoder;
/**
 *  反地理编码
 */
- (IBAction)reverseGeocode;
/**
 *  经度输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *longtitudeField;
/**
 *  纬度输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
/**
 *  反地理编码结果
 */
@property (weak, nonatomic) IBOutlet UILabel *reverseDetailAddressLabel;


@end

@implementation ViewController

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)reverseGeocode
{
    NSString *longtitude = self.longtitudeField.text;
    NSString *latitude = self.latitudeField.text;
    
    if (longtitude.length == 0 ||
        longtitude == nil ||
        latitude.length == 0 ||
        latitude == nil) {
        NSLog(@"请输入经纬度");
        return;
    }

    CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude doubleValue]  longitude:[longtitude doubleValue]];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
       
        for (CLPlacemark *placeMark in placemarks) {
            NSLog(@"%@ %@ %f %f", placeMark.name, placeMark.addressDictionary, placeMark.location.coordinate.latitude, placeMark.location.coordinate.longitude);
            
            self.reverseDetailAddressLabel.text = placeMark.locality;
        }
        
    }];
}
@end
