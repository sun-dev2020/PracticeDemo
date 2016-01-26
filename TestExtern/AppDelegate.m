//
//  AppDelegate.m
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    NSOperationQueue *taskQueue =[[NSOperationQueue alloc] init];
    NSBlockOperation *blockTask =[NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"_block Operation__");
    }];
    NSInvocationOperation *invocationTask =[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doneOperation) object:nil];
    [taskQueue addOperationWithBlock:^{
        NSLog(@"  with block");
    }];
    [blockTask addDependency:invocationTask];
    [taskQueue addOperation:blockTask];
    [taskQueue addOperation:invocationTask];
    
//    NSTimer *timer ;
//    [[NSRunLoop currentRunLoop ]addTimer:timer forMode:NSRunLoopCommonModes];
    
    return YES;
}
- (void)doneOperation{
    sleep(1);
    NSLog(@" done ");
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler{
//    
//    completionHandler();
//}



@end
