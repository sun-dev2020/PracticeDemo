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
#import "Header.h"
#import "Student.h"
#import "UIButton+ClickArea.h"
const NSString *externConstString =@"first";


extern NSString *url;

@interface ViewController ()
{
    NSString *nomalString;
    UIView *view;
    __block float angle ;
    __block BGView *yellow ;
}
@end

@implementation ViewController
@synthesize isallowornot = aisallowornot;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    aisallowornot = YES;

    NSLog(@" %d  %d ",self.isallowornot , aisallowornot);
   url =@"asdsad";
    
   staticString =@"new static";
   constString2 =@"new const";
//   constString =@"new constr";
   externConstString =@"new extern";
    NSLog(@"extern %@ const %@ const2 %@  static %@",externConstString,constString ,constString2,staticString);

    
    struct SSPoint aPoint ;
    aPoint.x =10 ;

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

    
    [self testForKVO];
    [self testForAddButtonClickArea];
    [self testForMutableCopy];
    
    [self testForURLSession];
}
- (void)awakeFromNib{
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    return self;
}
/**
*  增大button可点击区域
*/
- (void)testForAddButtonClickArea{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100.0f, 300.0f, 50.0f, 50.0f);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setClickAreaWithTop:20.0f left:20.0f bottom:20.0f right:20.0f];
}
- (void)btnClicked{
    NSLog(@" clicked  ");
    TTViewController*tt =[[TTViewController alloc]init];
    [self presentViewController:tt animated:YES completion:^{
        
    }];
}

/**
*  测试copy和mutableCopy
*/
- (void)testForMutableCopy{
    NSString *string = @"ABC";
    NSString *copyString = [string copy];
    NSMutableString *mCopyString = [string mutableCopy];
    string = @"DEF";
    NSLog(@" string: %@ , copy: %@ ,mcopy: %@  ",string,copyString,mCopyString);
    
    NSMutableString *mString = [NSMutableString stringWithFormat:@"mutableString"];
    NSMutableString *copyMString = [mString mutableCopy];
    NSString *copyStringm = [mString copy];
    mString = [NSMutableString stringWithFormat:@"changeMutableString"];
    NSLog(@" mstring:%@  , copy:%@ , mcopy:%@ ",mString,copyMString , copyStringm);
    
    //只有不可变对象的copy是指针拷贝（浅复制），其他情况都是内容拷贝（深复制）。
    id immutableObject , mutableObject;
    [immutableObject copy]; // 浅复制
    [immutableObject mutableCopy]; //单层深复制
    [mutableObject copy]; //单层深复制
    [mutableObject mutableCopy]; //单层深复制
    
    //@property()中copy的修饰，是指不管传过来的是可变的还是不可变的对象，本身都会持有一份对象不可变的副本
}


/**
*  测试KVO
*/
- (void)testForKVO{
    Student *student =[[Student alloc] init];
    student.age = 18 ;
    student.sex = YES ;
    student.name = @"jason";
    student.location = @"location";
    NSLog(@" property location: %@  ",student.g_location);
    NSArray *allStudent = @[student];
    // 归档模型对象
    NSString *documentPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentPath stringByAppendingPathComponent:@"student.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:allStudent toFile:path];
    
    // 从文件中读取模型对象
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    //    NSLog(@" Student name= %@, age= %d ,sex =%d ",stu.name ,stu.age ,stu.sex);
    NSLog(@" array = %@ %d ",array,success);
    
    //对象添加KVO
    [student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    student.name = @"code";
    
    //student dealloc前一定要执行remove
    [student removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@" observeObj:%@  change:%@ ",object,change);
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

- (void)testForURLSession{
    // NSURLSession  Data  upload  download
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@" session response : %@ ",response);
    }];
    [task resume];
    
    NSData *data = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }];
    [uploadTask resume];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSURL *documentsURL = [NSURL fileURLWithPath:documentsPath];
        NSURL *newFilePath = [documentsURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFilePath error:nil];
    }];
    [downloadTask resume];
}


@end
