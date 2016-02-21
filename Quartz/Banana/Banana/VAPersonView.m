//
//  VAPersonView.m
//  Banana
//
//  Created by MS on 15/5/14.
//  Copyright (c) 2015年 Van. All rights reserved.
//

#define VARadius 70
#define VATopY 100
#define VAColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#import "VAPersonView.h"

@implementation VAPersonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Drawing code
    // 1.画身体
    [[UIColor colorWithRed:252/255.0 green:221/255.0 blue:12/255.0 alpha:1] set];
    CGFloat bodyW = 150;
    CGFloat topCenterX = rect.size.width * 0.5;
    CGFloat topCenterY = 150;
    CGFloat topRadius = bodyW * 0.5;
    CGContextAddArc(ctx, topCenterX, topCenterY, topRadius, 0, M_PI, 1);
    
    CGFloat middleH = 100;
    CGFloat middleLeftX = topCenterX - bodyW * 0.5;
    CGContextAddLineToPoint(ctx, middleLeftX, middleH);
    
    CGFloat bottomCenterX = topCenterX;
    CGFloat bottomCenterY = topCenterY + middleH;
    CGContextAddArc(ctx, bottomCenterX, bottomCenterY, topRadius, M_PI, 0, 1);
    CGContextFillPath(ctx);
    
    // 2.画眼睛
    [[UIColor blackColor] set];
    CGFloat margin = 2;
    CGFloat badgeX = middleLeftX - margin;
    CGFloat badgeY = topCenterY - 10;
    CGFloat badgeW = bodyW + margin * 2;
    CGFloat badgeH = 15;
    CGContextAddRect(ctx, CGRectMake(badgeX, badgeY, badgeW, badgeH));
    CGContextFillPath(ctx);
    
    [[UIColor colorWithRed:79/255.0 green:78/255.0 blue:83/255.0 alpha:1] set];
    CGFloat eyeW = bodyW * 0.46;
    CGFloat leftEyeX = middleLeftX + eyeW * 0.5 + 10;
    CGFloat leftEyeY = badgeY + badgeH * 0.5;
    drawCircle(ctx, eyeW * 0.5, leftEyeX, leftEyeY);
    
    CGFloat rightEyeX = rect.size.width - leftEyeX;
    CGFloat rightEyeY = badgeY + badgeH * 0.5;
    drawCircle(ctx, eyeW * 0.5, rightEyeX, rightEyeY);
    CGContextFillPath(ctx);
    
    [[UIColor whiteColor] set];
    CGFloat innerEyeW = eyeW * 0.7;
    drawCircle(ctx, innerEyeW * 0.5, leftEyeX, leftEyeY);
    drawCircle(ctx, innerEyeW * 0.5, rightEyeX, rightEyeY);
    CGContextFillPath(ctx);
    
    [[UIColor colorWithRed:99/255.0 green:29/255.0 blue:10/255.0 alpha:1] set];
    CGFloat leftBrownX = leftEyeX + 10;
    CGFloat rightBrownX = rightEyeX - 10;
    drawCircle(ctx, 10, leftBrownX, leftEyeY);
    drawCircle(ctx, 10, rightBrownX, leftEyeY);
    CGContextFillPath(ctx);
    
    [[UIColor blackColor] set];
    drawCircle(ctx, 4, leftBrownX, leftEyeY);
    drawCircle(ctx, 4, rightBrownX, leftEyeY);
    CGContextFillPath(ctx);
    
    [[UIColor whiteColor] set];
    drawCircle(ctx, 2, leftBrownX - 3, leftEyeY - 3);
    drawCircle(ctx, 2, rightBrownX - 3, leftEyeY - 3);
    CGContextFillPath(ctx);
    
    // 3.弧线
    [[UIColor blackColor] set];
    CGFloat centerY = topCenterY + middleH * 0.7;
    CGFloat cp1x = topCenterX - 30;
    CGFloat cp2x = rect.size.width - cp1x;
    CGFloat cpy = centerY - 15;
    CGContextMoveToPoint(ctx, cp1x, cpy);
    CGContextAddQuadCurveToPoint(ctx, topCenterX, centerY, cp2x, cpy);
    CGContextStrokePath(ctx);
    
    // 4.头发
    CGContextMoveToPoint(ctx, topCenterX, topCenterY - topRadius + 5);
    CGContextAddLineToPoint(ctx, topCenterX, topCenterX - topRadius - 30);
    
    
    CGContextMoveToPoint(ctx, topCenterX - 10, topCenterY - topRadius + 5);
    CGContextAddLineToPoint(ctx, topCenterX - 20, topCenterX - topRadius - 30);
    
    
    CGContextMoveToPoint(ctx, topCenterX + 10, topCenterY - topRadius + 5);
    CGContextAddLineToPoint(ctx, topCenterX + 20, topCenterX - topRadius - 30);
    
    
    
    CGContextMoveToPoint(ctx, topCenterX - 20, topCenterY - topRadius + 7);
    CGContextAddLineToPoint(ctx, topCenterX - 30, topCenterX - topRadius - 30);
    
    
    CGContextMoveToPoint(ctx, topCenterX + 20, topCenterY - topRadius + 7);
    CGContextAddLineToPoint(ctx, topCenterX + 30, topCenterX - topRadius - 30);
    CGContextStrokePath(ctx);
}

void drawCircle(CGContextRef ctx, int radius, CGFloat centerX, CGFloat centerY)
{
    CGContextAddArc(ctx, centerX, centerY, radius, M_PI * 2, 0, 0);
}

void drawEyes(CGContextRef ctx, CGRect rect)
{
    // 1.黑色绑带
    CGFloat startX = rect.size.width * 0.5 - VARadius;
    CGFloat startY = VATopY;
    CGContextMoveToPoint(ctx, startX, startY);
    CGFloat endX = startX + 2 * VARadius;
    CGFloat endY = startY;
    CGContextAddLineToPoint(ctx, endX, endY);
    CGContextSetLineWidth(ctx, 15);
    [[UIColor blackColor] set];
    // 绘制线条
    CGContextStrokePath(ctx);
    
    
    [VAColor(61, 62, 66) set];
    CGFloat glassRadius = VARadius * 0.4;
    CGFloat glassY = startY;
    CGFloat glassX = rect.size.width * 0.5 -glassRadius;
    
    CGContextAddArc(ctx, glassX, glassY, glassRadius, 0, M_PI * 2, 0);
    
    CGContextFillPath(ctx);
    
    [VAColor(61, 62, 66) set];
    CGFloat glassRadius2 = VARadius * 0.4;
    CGFloat glassY2 = startY;
    CGFloat glassX2 = rect.size.width * 0.5 +glassRadius;
    
    CGContextAddArc(ctx, glassX2, glassY2, glassRadius2, 0, M_PI * 2, 0);
    
    CGContextFillPath(ctx);
    
    [[UIColor whiteColor] set];
    CGFloat whiteRadius = glassRadius * 0.7;
    CGFloat whiteX = glassX;
    CGFloat whiteY = glassY;
    CGContextAddArc(ctx, whiteX, whiteY, whiteRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    [[UIColor whiteColor] set];
    CGFloat whiteRadius2 = glassRadius * 0.7;
    CGFloat whiteX2 = glassX2;
    CGFloat whiteY2 = glassY2;
    CGContextAddArc(ctx, whiteX2, whiteY2, whiteRadius2, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
}

void drawMouth(CGContextRef ctx, CGRect rect)
{
    CGFloat controlX = rect.size.width * 0.5;
    CGFloat controlY = rect.size.height * 0.4;
    
    // 当前点
    CGFloat marginX = 20;
    CGFloat marginY = 10;
    CGFloat currentX = controlX - marginX;
    CGFloat currentY = controlY - marginY;
    CGContextMoveToPoint(ctx, currentX, currentY);
    
    // 结束点
    CGFloat endX = controlX + marginX;
    CGFloat endY = currentY;
    
    // 贝塞尔曲线
    CGContextAddQuadCurveToPoint(ctx, controlX, controlY, endX, endY);
    
    // 设置颜色
    [[UIColor blackColor] set];
    
    // 渲染
    CGContextStrokePath(ctx);
}

void drawBody(CGContextRef ctx, CGRect rect)
{
    CGFloat topX = rect.size.width * 0.5;
    CGFloat topY = VATopY;
    CGFloat topRadius = VARadius;
    CGContextAddArc(ctx, topX, topY, topRadius, 0, M_PI, 1);
    
    CGFloat middleX = topX -topRadius;
    CGFloat middleH = 100;
    CGFloat middleY = topY + middleH;
    CGContextAddLineToPoint(ctx, middleX, middleY);
    
    CGFloat bottomX = topX;
    CGFloat bottomY = middleY;
    CGFloat bottomRadius = topRadius;
    CGContextAddArc(ctx, bottomX, bottomY, bottomRadius, M_PI, 0, 1);
    
    CGContextClosePath(ctx);
    
    [VAColor(252, 218, 0) set];
    
    CGContextFillPath(ctx);
}
@end
