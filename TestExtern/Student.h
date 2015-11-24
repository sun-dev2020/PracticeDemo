//
//  Student.h
//  TestExtern
//
//  Created by keyrun on 15-1-5.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject  <NSCoding>

@property (nonatomic ,assign) int age;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,assign) BOOL sex;

@property (nonatomic ,strong,setter = s_location: , getter= g_location) NSString *location;

@end
