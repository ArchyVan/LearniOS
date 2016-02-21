//
//  VAStatusFrame.h
//  TableView3
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VAStatus;

@interface VAStatusFrame : NSObject

@property (nonatomic, assign,readonly) CGRect iconF;

@property (nonatomic, assign,readonly) CGRect nameF;

@property (nonatomic, assign,readonly) CGRect vipF;

@property (nonatomic, assign,readonly) CGRect textF;

@property (nonatomic, assign,readonly) CGRect pictureF;

@property (nonatomic, assign,readonly) CGFloat cellHeight;

@property (nonatomic,strong)VAStatus * status;
@end
