//
//  ViewController.m
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "ViewController.h"
#import "TTViewController.h"
#import "BGView.h"
const NSString *externConstString =@"first";

@interface ViewController ()
{
    NSString *nomalString;
    UIView *view;
    __block float angle ;
    __block BGView *yellow ;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional seatup after loading the view, typically from a nib.
   staticString =@"new static";
   constString2 =@"new const";
//   constString =@"new constr";
   externConstString =@"new extern";
    NSLog(@"extern %@ const %@ const2 %@  static %@",externConstString,constString ,constString2,staticString);
    
    TTViewController*tt =[[TTViewController alloc]initWithNibName:nil bundle:nil];
    
//    [self.navigationController pushViewController:tt animated:YES];
    struct SSPoint aPoint ;
    aPoint.x =10 ;
    NSLog(@"POint == %d",oPoint.m);
    self.scrollView.hidden = YES;
    self.scrollView.backgroundColor =[UIColor lightGrayColor];
    self.scrollView.contentSize =CGSizeMake(320, 800);
    self.scrollView.delegate =self;
    
    
    yellow = [[BGView alloc] initWithFrame:CGRectMake(50, 50, 232, 232)];
    [self.view addSubview:yellow];
    
    view =[[UIView alloc] initWithFrame:CGRectMake(50, 50, 232, 232)];
    UIImageView *head =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_view_bg"]];
    head.frame = CGRectMake(50, 50, 232, 232);
    [self.view addSubview:head];

    UIImageView *head2 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_view_head"]];
    head2.frame = CGRectMake(232/2 -59/2, 0, 59, 17);
    [view addSubview:head2];
    
    view.layer.cornerRadius = view.frame.size.width/2 ;
    
    [self.view addSubview:view];
    
    [self change];
    
    
    
//    [CATransaction begin];
//    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
//    CGRect frame = self.headImage.frame ;
//    self.headImage.layer.anchorPoint = self.headImage.center ;
//    self.headImage.layer.position =
    
}
-(void)change{
    [UIView animateWithDuration:0.0001 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform = CGAffineTransformMakeRotation(angle *( M_PI /180.0f));
    } completion:^(BOOL finished) {
        angle += 1;
        yellow.angle += 1;
        [self change];
    }];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" offSet %@   inset %@",NSStringFromCGPoint(scrollView.contentOffset),NSStringFromUIEdgeInsets(scrollView.contentInset));
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset ;
    CGRect bounds  = scrollView.bounds ;
    CGSize size = scrollView.contentSize ;
    UIEdgeInsets insets = scrollView.contentInset ;
    float y = offset.y + bounds.size.height - insets.bottom ;
    float h = size.height ;
    if (y > h -1) {
        NSLog(@" refresh... ");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(id)shareObject{
    
    externConstString =@"asdd";
    staticString =@"sad";
    constString2 =@"mmmm";
    NSLog(@"extern %@ const %@ const2 %@  static %@",externConstString,constString ,constString2,staticString);
//    constString =@"asd";
    return nil;
}
@end
