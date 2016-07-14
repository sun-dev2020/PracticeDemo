//
//  Person.m
//  
//
//  Created by mac on 16/1/27.
//
//

#import "Person.h"

@implementation Person

-(instancetype)init{
//    self.sex = YES;
    NSLog(@" ___ %@ ",[super init]);
    return [super init];
}

- (id)copyWithZone:(nullable NSZone *)zone{
    Person *person = [[Person allocWithZone:zone] init];
    return person;
}
- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    Person *person = [[Person allocWithZone:zone] init];
    person.sex = _sex;
    return person;
}
@end
