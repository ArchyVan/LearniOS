//
//  ViewController.m
//  DrawRoute
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)drawLine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
}
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (IBAction)drawLine {
    
    NSString *startStr = @"北京";
    NSString *endStr = @"云南";

    [self.geocoder geocodeAddressString:startStr completionHandler:^(NSArray *placemarks, NSError *error) {
        
        
        if (placemarks.count == 0) return;
        
        // 开始位置的地标
        CLPlacemark *startCLPlacemark = [placemarks firstObject];

        
        [self.geocoder geocodeAddressString:endStr completionHandler:^(NSArray *placemarks, NSError *error) {
            if (placemarks.count == 0) return;
            
            // 结束位置的地标
            CLPlacemark *endCLPlacemark = [placemarks firstObject];

            [self startDirectionsWithstartCLPlacemark:startCLPlacemark endCLPlacemark:endCLPlacemark];
        }];
        
    }];
}

- (void)startDirectionsWithstartCLPlacemark:(CLPlacemark *)startCLPlacemark endCLPlacemark:(CLPlacemark *)endCLPlacemark
{
    MKPlacemark *startMKPlacemark = [[MKPlacemark alloc] initWithPlacemark:startCLPlacemark];
    MKMapItem *startItem = [[MKMapItem alloc] initWithPlacemark:startMKPlacemark];
    
    MKPlacemark *endMKPlacemark = [[MKPlacemark alloc] initWithPlacemark:endCLPlacemark];
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:endMKPlacemark];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = startItem;
    
    request.destination = endItem;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        
        NSArray *routes = response.routes;
        
        for (MKRoute *route in routes) {
            NSLog(@"%f千米 %f小时", route.distance / 1000, route.expectedTravelTime/ 3600);

            
            [self.mapView addOverlay:route.polyline];
            
            NSArray *steps = route.steps;
            
            for (MKRouteStep *step in steps) {
                NSLog(@"%@ %f", step.instructions, step.distance);
            }
        }
        
    }];

}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    NSLog(@"%s",__func__);
    
    MKPolylineRenderer *line = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    
    line.lineWidth = 5;
    
    line.strokeColor = [UIColor redColor];
    
    return line;
}
@end
