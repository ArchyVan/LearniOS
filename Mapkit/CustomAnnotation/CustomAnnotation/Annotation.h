//
//  Annotation.h
//  CustomAnnotation
//
//  Created by Archy on 15/6/17.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject
/**
 *  大头针位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/**
 *  大头针标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  大头针子标题
 */
@property (nonatomic, copy) NSString *subtitle;
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;

@end
