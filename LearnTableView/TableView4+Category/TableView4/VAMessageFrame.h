//
//  VAMessageFrame.h
//  TableView4
//
//  Created by MS on 15-5-5.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#define VATextFont [UIFont systemFontOfSize:15]

#define VATextPadding 20

#import <Foundation/Foundation.h>

@class VAMessage;

@interface VAMessageFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;

@property (nonatomic, assign, readonly) CGRect timeF;

@property (nonatomic, assign, readonly) CGRect textF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic,strong)VAMessage * message;

@end
