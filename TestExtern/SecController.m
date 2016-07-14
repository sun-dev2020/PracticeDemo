//
//  SecController.m
//  PracticeDemo
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 keyrun. All rights reserved.
//

#import "SecController.h"

@implementation SecController
{
    UIImageView *_imageView;
}
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor orangeColor];
    [super viewDidLoad];
    
    [self initLottery];
}

-(void)initLottery{
    UILabel *labelL        = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 200)];
    labelL.text            = @"刮刮乐效果展示";
    labelL.numberOfLines   = 0;
    labelL.backgroundColor = [UIColor brownColor];
    labelL.font            = [UIFont systemFontOfSize:30];
    labelL.textAlignment   = NSTextAlignmentCenter;
    [self.view addSubview:labelL];
    
    // 被刮的图片
    _imageView       = [[UIImageView alloc] initWithFrame:labelL.frame];
    _imageView.image = [UIImage imageNamed:@"connect_view_bg"];
    [self.view addSubview:_imageView];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint centerPoint = [touch locationInView:_imageView];
    CGRect rect = CGRectMake(centerPoint.x, centerPoint.y, 20, 20);
    
    UIGraphicsBeginImageContextWithOptions(_imageView.bounds.size, NO, 0);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    [_imageView.layer renderInContext:ref];
    CGContextClearRect(ref, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imageView.image = image;
    
}

@end
