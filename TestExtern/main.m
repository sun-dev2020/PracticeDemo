//
//  main.m
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[])
{
//#ifndef DEBUG
////    ptrace(PT_DENY_ATTACH, 0, 0, 0);
//#endif
//    
//#ifdef DEBUG
//    NSLog(@" debug: %d",DEBUG);
//#else
//    NSLog(@"release");
//#endif
//
//#ifndef SOME 
//#define ADDTEN(x)    (x + 10)
//    NSLog(@" %d",ADDTEN(1));
//#endif
    static NSString *string = @"b";
    @autoreleasepool {
        int i = 1024;
        void (^block1)(void) = ^{
            string = @"v";
            printf("%d\n", i);
        };
        block1();
        NSLog(@"%@", block1);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }

}
