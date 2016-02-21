//
//  AnnotationView.m
//  CustomAnnotation
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import "AnnotationView.h"
#import "Annotation.h"

@implementation AnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.canShowCallout = YES;
        
        self.leftCalloutAccessoryView = [[UISwitch alloc] init];
        
        self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }
    return self;
}
+ (instancetype)annotationViewWithMap:(MKMapView *)mapView
{
    static NSString *identifier = @"anno";
    
    AnnotationView *annoView = (AnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annoView == nil) {
        annoView = [[AnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
    }
    return annoView;
}

- (void)setAnnotation:(Annotation *)annotation
{
    [super setAnnotation:annotation];
    
    self.image = [UIImage imageNamed:annotation.icon];
}
@end
