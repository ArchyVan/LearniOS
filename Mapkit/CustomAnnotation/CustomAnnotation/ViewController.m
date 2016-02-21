//
//  ViewController.m
//  CustomAnnotation
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "AnnotationView.h"

@interface ViewController ()<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *customView;

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
    
    self.customView.rotateEnabled = NO;
    
    self.customView.delegate = self;
    
    self.customView.userTrackingMode = MKUserTrackingModeFollow;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[Annotation class]] == NO) {
        return nil;
    }
    
    AnnotationView *annoView = [AnnotationView annotationViewWithMap:mapView];
    
    annoView.annotation = annotation;
    
    return annoView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        NSLog(@"获取地理位置成功 name = %@ locality = %@", placemark.name, placemark.locality);
        userLocation.title = placemark.name;
        userLocation.subtitle = placemark.locality;

    }];
    
    [self.customView setCenterCoordinate:userLocation.location.coordinate animated:YES];
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return  _geocoder;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}
- (void) addAnnotation
{
    Annotation *anno = [[Annotation alloc] init];
    
    anno.title = @"QF";
    anno.subtitle = @"BSLXQ";
    
    CGFloat latitude = 36.821199 + arc4random_uniform(20);
    CGFloat longitude = 116.858776 + arc4random_uniform(20);
    
    anno.coordinate= CLLocationCoordinate2DMake(latitude, longitude);
    
    anno.icon = @"321";
    
    [self.customView addAnnotation:anno];
}
@end
