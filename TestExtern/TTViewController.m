//
//  TTViewController.m
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController () <NSURLSessionDelegate , NSURLSessionDownloadDelegate>
{
    int count;
    NSURLSessionDownloadTask *downloadTask ;
    NSURLSession *session ;
    NSData *oldData;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveBackgroundTask) name:@"receiveBackgroundTask" object:nil];
//    [NSTimer scheduledTimerWithTimeInterval:35.0f target:self selector:@selector(testForBackgroundRequest) userInfo:nil repeats:NO];
//    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(printCount) userInfo:nil repeats:YES];

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES); NSString *path = [paths lastObject];
//    NSLog(@" path %@ ",path);

   
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(100, 100, 100, 100);
    [startBtn addTarget:self action:@selector(testForBackgroundRequest) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setBackgroundColor:[UIColor orangeColor]];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [self.view addSubview:startBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(100, 240, 100, 100);
    [endBtn addTarget:self action:@selector(pasure) forControlEvents:UIControlEventTouchUpInside];
    [endBtn setBackgroundColor:[UIColor redColor]];
    [endBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.view addSubview:endBtn];
    
    
}
- (void)pasure{
    [downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        NSLog(@" resumeData : %lu ",(unsigned long)resumeData.length);
        oldData = [NSData dataWithData:resumeData];
    }];
}
- (void)testForBackgroundRequest{
    NSLog(@" send background request!!! ");
    if (oldData.length > 0) {
        downloadTask = [session downloadTaskWithResumeData:oldData];
        [downloadTask resume];
        return;
    }
    NSURL *url = [NSURL URLWithString:@"http://cdnpatch.popkart.com/lexian/kart_patch/VBUHTBSVRUQZPMV/PopKart_Patch_P2046.exe"];
//    NSURL *url = [NSURL URLWithString:@"http://corsarus.com/AppData/BlogSamples/201412/NSURLSession/img/photo3.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    session = [self backgroundSession];
    //如果使用background模式 就使用downloadTaskWithRequest  而不是-downloadTaskWithRequest completionHandler 否则会crash
    if (session) {
        // 获取app上次关闭的未完成的后台任务
        __block UIBackgroundTaskIdentifier bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        }];
        [session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
            NSLog(@"  downloadTasks ======== %@ ",downloadTasks);
            for (NSURLSessionDownloadTask *task in downloadTasks) {
//                [task resume];
            }
        }];
    }
    
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSURL *cacheDirectoryURL = [[[defaultFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Cache" isDirectory:YES];
    NSURL *downloadedFileURL = [cacheDirectoryURL URLByAppendingPathComponent:@"photo3.png"];
    if ([defaultFileManager fileExistsAtPath:downloadedFileURL.path]) {
        NSData *data = [NSData dataWithContentsOfURL:downloadedFileURL];
        if (data.length > 0) {
            downloadTask = [session downloadTaskWithResumeData:data];
        }
    }else{
        downloadTask = [session downloadTaskWithRequest:request];
    }
    
//    downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        
//        NSLog(@" response %d %d ",[NSThread isMultiThreaded], [NSThread isMainThread]);
//    }];
    /*
     (NSURL *location, NSURLResponse *response, NSError *error) {
     NSLog(@" download success  error: %@ ",error);
     NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
     NSURL *documentsURL = [NSURL fileURLWithPath:documentsPath];
     NSURL *newFilePath = [documentsURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
     [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFilePath error:nil];
     */
    [downloadTask resume];
    
    /*
    NSData *data = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromFile:nil];
    [uploadTask resume];
    */

}
- (void)receiveBackgroundTask{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"通知" message:@"接受到后台请求" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}
// iOS7 NSURLSession后台请求
- (NSURLSession *)backgroundSession{
    static NSURLSession *session2 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.witown.ApManager.url"];
        session2 = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    });
    return session2;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
    
}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
//    NSLog(@" url session invalid  ");
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
//    NSLog(@" session did finish events ");
}


#pragma mark - **************** download delegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@" URLLocation %@  ",location.path);
    NSFileManager *defaultFileManager = [NSFileManager defaultManager];
    NSURL *cacheDirectoryURL = [[[defaultFileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Cache" isDirectory:YES];
    if (![defaultFileManager fileExistsAtPath:cacheDirectoryURL.path]) {
        [defaultFileManager createDirectoryAtPath:cacheDirectoryURL.path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSURL *downloadedFileURL = [cacheDirectoryURL URLByAppendingPathComponent:downloadTask.originalRequest.URL.lastPathComponent];
    
    [defaultFileManager removeItemAtPath:downloadedFileURL.path error:nil];
   BOOL success =  [defaultFileManager moveItemAtPath:location.path toPath:downloadedFileURL.path error:nil];
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@" task: %lld  ,write %lld  total %lld ",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    
    NSLog(@" resumeAtOffSet  %lld ",fileOffset);
}









- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
