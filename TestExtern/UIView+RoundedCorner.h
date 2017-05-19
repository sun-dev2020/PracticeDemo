//
//  UIView+RoundedCorner.h
//  PracticeDemo
//
//  Created by mac on 2017/5/5.
//  Copyright © 2017年 keyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundedCorner)

- (void)addCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)bgColor borderColor:(UIColor *)bColor;
- (void)addCorner;

+ (void)share;
@end
