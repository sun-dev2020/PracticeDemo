//
//  Student.h
//  TestExtern
//
//  Created by keyrun on 15-1-5.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "Person.h"

@interface Student : Person  <NSCoding , JSExport>

@property (nonatomic ,assign) int age;
@property (nonatomic ,strong) NSString *name;

@property (nonatomic ,strong,setter = s_location: , getter= g_location) NSString *location;

@end
