//
//  AppDelegate.h
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CGBase.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

//内联函数
//CG_INLINE
static inline bool
CGPointYEqualToPoint(CGPoint a , CGPoint b){
    return a.y == b.y;
}
