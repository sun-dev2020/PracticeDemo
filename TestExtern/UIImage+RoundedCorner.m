//
//  UIImage+RoundedCorner.m
//  PracticeDemo
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 keyrun. All rights reserved.
//

#import "UIImage+RoundedCorner.h"

@implementation UIImage (RoundedCorner)

- (UIImage*)sh_imageWithRoundedCornersAndSize:(CGSize)size andRoundedRadius:(CGFloat)radius
{
    CGRect rect = { 0.f, 0.f, size };
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());

    [self drawInRect:rect];
    UIImage* output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

@end
