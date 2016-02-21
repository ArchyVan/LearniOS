//
//  CustomURLConnection.h
//  CustomURLConnection
//
//  Created by Archy on 15/6/24.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CustomURLConnection;
@protocol CustomURLConnection <NSObject>

- (void)customConnection:(CustomURLConnection *)connection didReceiveResponse:(NSDictionary *)response;

- (void)customConnection:(CustomURLConnection *)connection didReceiveData:(NSData *)data;


@end

@interface CustomURLConnection : NSObject

@property (nonatomic, retain) NSThread *thread;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) id delegate;
- (id) initWithUrl:(NSURL *)url delegate:(id)delegate;

@end
