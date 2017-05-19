//
//  UIView+RoundedCorner.m
//  PracticeDemo
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 keyrun. All rights reserved.
//

#import "UIView+RoundedCorner.h"

@implementation UIView (RoundedCorner)

-(UIImage *)drawRectWithRoundedCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)bgColor border:(UIColor *)bColor{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize size = CGSizeMake(self.bounds.size.width,  self.bounds.size.height);
    CGFloat halfBorderWidth = borderWidth/2.f;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, bColor.CGColor);
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    
    CGContextMoveToPoint(context, size.width - halfBorderWidth, radius + halfBorderWidth);
    CGContextAddArcToPoint(context, size.width - halfBorderWidth, size.height - halfBorderWidth , size.width - radius - halfBorderWidth, size.height - halfBorderWidth, radius);
    CGContextAddArcToPoint(context, halfBorderWidth, size.height - halfBorderWidth, halfBorderWidth, size.height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, size.width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, size.width - halfBorderWidth, halfBorderWidth, size.width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathEOFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


- (void)addCorner{
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5.f, 5)];
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.fillColor = [UIColor redColor].CGColor;
    maskLayer.path = maskPath.CGPath;
    maskLayer.backgroundColor= [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:maskLayer];
}


- (void)addCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)bColor{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [self drawRectWithRoundedCorner:radius borderWidth:borderWidth backgroundColor:bgColor border:bColor];
    [self insertSubview:imageView atIndex:0];
}

+ (void)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}
@end
