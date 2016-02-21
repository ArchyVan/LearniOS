//
//  CustomDownloadOperation.h
//  Cell_ImageView_Download
//
//  Created by Archy on 15/6/4.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CustomDownloadOperation;

@protocol CustomDownloadOperationDelegate <NSObject>

- (void)downloadOperation:(CustomDownloadOperation *)operation didFinishedDownload:(UIImage *)image;

@end

@interface CustomDownloadOperation : NSOperation
@property (nonatomic, copy) NSString *imageUrl;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic, weak) id<CustomDownloadOperationDelegate> delegate;

@end
