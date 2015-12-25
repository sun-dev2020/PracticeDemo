//
//  CoderModel.m
//  PracticeDemo
//
//  Created by mac on 15/12/16.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import "CoderModel.h"

@implementation CoderModel

-(instancetype)initCodeModelWith:(NSDictionary *)dic{
    self = [super init];
    if (self) {

        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    NSLog(@"setValue: %@   %@",value,key);
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@" value: %@ , undefinedKey: %@",value, key);
}

@end
