//
//  Student.m
//  TestExtern
//
//  Created by keyrun on 15-1-5.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import "Student.h"
#define ageKey      @"age"
#define sexKey      @"sex"
#define nameKey     @"name"
@implementation Student

/**
*  将对象写入文件时调用
*
*  @param aCoder
*/
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:self.age forKey:ageKey];
    [aCoder encodeObject:self.name forKey:nameKey];
    [aCoder encodeBool:self.sex forKey:sexKey];
}

/**
*  从文件中解析对象时调用 , 注意encode和decoder时参数的类型对应
*
*  @param aDecoder
*
*  @return 对象
*/
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.age = [aDecoder decodeIntForKey:ageKey];
        self.name = [aDecoder decodeObjectForKey:nameKey];
        self.sex = [aDecoder decodeBoolForKey:sexKey];
    }
    return self;
}
+ (BOOL)resolveClassMethod:(SEL)sel{
    return YES;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    return nil;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return nil;
}
@end
