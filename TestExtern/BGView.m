//
//  BGView.m
//  TestExtern
//
//  Created by keyrun on 14-9-24.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "BGView.h"

@implementation BGView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}
-(void)setBackColor:(UIColor *)backColor{
    
    self.backgroundColor = backColor;
}
-(void)setAngle:(float)angle{
    _angle = angle ;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext() ;
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextSetLineWidth(context, 4.0f);
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), self.bounds.size.width/2-2 , -90 *(M_PI /180.0f), _angle*(M_PI /180.0f) + -90*(M_PI /180.0f), 0);
    CGContextStrokePath(context);
}

@end
