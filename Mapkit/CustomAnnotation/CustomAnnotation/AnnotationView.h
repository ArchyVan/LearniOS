//
//  AnnotationView.h
//  CustomAnnotation
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface AnnotationView : MKAnnotationView

+ (instancetype) annotationViewWithMap:(MKMapView *)mapView;

@end
