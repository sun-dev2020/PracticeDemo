//
//  UIButton+ClickArea.m
//  CodeForTest
//
//  Created by mac on 15/11/24.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import "UIButton+ClickArea.h"
#import <objc/runtime.h>

@implementation UIButton (ClickArea)

static char topKey;
static char leftKey;
static char bottomKey;
static char rightKey;

@dynamic need;

-(BOOL)need{
    return objc_getAssociatedObject(self, "needkey");
}
-(void)setNeed:(BOOL)need{
    objc_setAssociatedObject(self, "needkey", @(need), OBJC_ASSOCIATION_COPY);
}

- (void)setClickAreaWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    objc_setAssociatedObject(self, &topKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)clickAreaRect{
    float top = [objc_getAssociatedObject(self, &topKey) floatValue];
    float left = [objc_getAssociatedObject(self, &leftKey) floatValue];
    float bottom = [objc_getAssociatedObject( self, &bottomKey) floatValue];
    float right = [objc_getAssociatedObject(self, &rightKey) floatValue];
    if (top != 0 && left != 0 && bottom != 0 && right != 0) {
        return CGRectMake(self.bounds.origin.x - left, self.bounds.origin.y - top, self.bounds.size.width + left + right, self.bounds.size.height + top + bottom);
    }else{
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self clickAreaRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }else{
        //判断点击点是否在rect内
        return CGRectContainsPoint(rect, point) ? self : nil;
    }
}


//-------测试分类添加的属性能否支持KVO----支持---//
- (void)setAdress:(NSString *)adress{
    objc_setAssociatedObject(self, "adress", adress, OBJC_ASSOCIATION_COPY);
}
- (NSString *)adress{
    return objc_getAssociatedObject(self, "adress");
}




@end
