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
    self.sex = YES;
    NSLog(@" ___ %@ ",[super init]);
    return [super init];
}



@end
