//
//  TTViewController.m
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController () <NSURLSessionDelegate>
{
    int count;
}
@end

@implementation TTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)awakeFromNib{
    NSLog(@" awakeFromNib ");
}
- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor orangeColor];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveBackgroundTask) name:@"receiveBackgroundTask" object:nil];
    [NSTimer scheduledTimerWithTimeInterval:35.0f target:self selector:@selector(testForBackgroundRequest) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(printCount) userInfo:nil repeats:YES];
//    [self testForBackgroundRequest];
}
- (void)printCount{
    NSLog(@"  repeat count : %d  ",count++);
}
- (void)testForBackgroundRequest{
    NSLog(@" send background request!!! ");
    NSURL *url = [NSURL URLWithString:@"http://s1.music.126.net/download/osx/NeteaseMusic_1.3.1_366_web.dmg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [self backgroundSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSLog(@" download success  error: %@ ",error);
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSURL *documentsURL = [NSURL fileURLWithPath:documentsPath];
        NSURL *newFilePath = [documentsURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFilePath error:nil];
    }];
    [downloadTask resume];

}
- (void)receiveBackgroundTask{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:@"接受到后台请求" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
// iOS7 NSURLSession后台请求
- (NSURLSession *)backgroundSession{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    });
    return session;
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
    
}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    NSLog(@" url session invalid  ");
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    NSLog(@" session did finish events ");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
