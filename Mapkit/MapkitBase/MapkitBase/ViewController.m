//
//  ViewController.m
//  MapkitBase
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *customMapView;

@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        self.manager = [[CLLocationManager alloc] init];
        
        [self.manager requestAlwaysAuthorization];
    }
    
    self.customMapView.delegate = self;
    
    self.customMapView.userTrackingMode=  MKUserTrackingModeFollow;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        
        NSLog(@"获取地理位置成功 name = %@ locality = %@", placemark.name, placemark.locality);

        userLocation.title = placemark.name;
        userLocation.subtitle = placemark.locality;
    }];
    
    
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    [self.customMapView setRegion:region animated:YES];
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%f %f", self.customMapView.region.span.latitudeDelta, self.customMapView.region.span.longitudeDelta);
}
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
@end
