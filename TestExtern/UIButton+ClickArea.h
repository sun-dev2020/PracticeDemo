//
//  UIButton+ClickArea.h
//  CodeForTest
//
//  Created by mac on 15/11/24.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ClickArea)

@property(nonatomic, assign) BOOL need;

- (void)setClickAreaWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;


- (void)setAdress:(NSString *)adress;
- (NSString *)adress;


@end
