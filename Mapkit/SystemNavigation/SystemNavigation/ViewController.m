//
//  ViewController.m
//  SystemNavigation
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
@interface ViewController ()
- (IBAction)startNavigation;

@property (weak, nonatomic) IBOutlet UITextField *startField;
@property (weak, nonatomic) IBOutlet UITextField *endField;
@property (strong, nonatomic) CLGeocoder *geocoder;

@end

@implementation ViewController

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (IBAction)startNavigation {
    
    NSString *startStr = self.startField.text;
    NSString *endStr = self.endField.text;
    
    if (startStr == nil || startStr.length == 0 || endStr == nil || endStr.length == 0) {
        NSLog(@"Please input something");
        return;
    }
    
    
    [self.geocoder geocodeAddressString:startStr completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0) {
            return ;
        }
        
        CLPlacemark *startCLPlacemark = [placemarks firstObject];
        
        [self.geocoder geocodeAddressString:endStr completionHandler:^(NSArray *placemarks, NSError *error) {
           
            if (placemarks.count == 0) {
                return ;
            }
            
            CLPlacemark *endCLPlacemark = [placemarks firstObject];
            
            [self startNavigationWithStartCLPlacemark:startCLPlacemark endCLPlacemark:endCLPlacemark];
            
        }];
    }];
    
}
- (void)startNavigationWithStartCLPlacemark:(CLPlacemark *)startCLPlacemark endCLPlacemark:(CLPlacemark *)endCLPlacemark
{
    MKPlacemark *startPlacemark = [[MKPlacemark alloc] initWithPlacemark:startCLPlacemark];
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
    
    MKPlacemark *endPlacemark = [[MKPlacemark alloc] initWithPlacemark:endCLPlacemark];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endPlacemark];
    
    NSArray *items = @[startItem,endItem];
    
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    
    [MKMapItem openMapsWithItems:items launchOptions:options];
}


@end
