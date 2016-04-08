//
//  CoderModel.m
//  PracticeDemo
//
//  Created by mac on 15/12/16.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import "CoderModel.h"
#import "Student.h"
@implementation CoderModel

//@synthesize key1 = _key1;

//-------以下是键值观察依赖键实现------（一个属性的值依赖另外一个对象中的一个或多个属性值时  当对象的属性值发生改变时通知）-------//

-(id)init:(Student *)student{
    self = [super init];
    if (self) {
        _student = student;
    }
    return self;
}

-(NSString *)information{
    return [[NSString alloc]initWithFormat:@"k#%d",_student.age];
}
-(void)setInformation:(NSString *)information{
    NSArray * array = [information componentsSeparatedByString:@"#"];
    [_student setAge:[[array objectAtIndex:1] intValue]];
}

+(NSSet *)keyPathsForValuesAffectingInformation{
    NSSet *keypaths = [[NSSet alloc] initWithObjects:@"student.age", nil];
    return keypaths;
}

//通用的实现依赖键，先获取父类实现  然后如果key对应 再把依赖属性的key-path加上
/*
+(NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    NSSet *keypaths = [super keyPathsForValuesAffectingValueForKey:key];
    NSArray *moreKeypaths = nil;
    if ([key isEqualToString:@"information"]) {
        moreKeypaths = @[@"student.age"];
    }
    if (moreKeypaths) {
        keypaths = [keypaths setByAddingObjectsFromArray:moreKeypaths];
    }
    return keypaths;
}
*/


//------以下是手动实现KVO--------//

-(instancetype)initCodeModelWith:(NSDictionary *)dic{
    self = [super init];
    if (self) {

//        [self setValuesForKeysWithDictionary:dic];
        key1 = @"";
        
        //手动实现KVO，第一种， 在重写set方法里面调用willChangeValueForKey和didChangeValueForKey方法
        //第二种，声明称属性值就可以有KVO了
    }
    return self;
}

// 手动实现KVO
-(NSString *)key1{
    return key1;
}
-(void)setKey1:(NSString *)key{
    [self willChangeValueForKey:@"key1"];
    key1 = key;
    [self didChangeValueForKey:@"key1"];
}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    if ([key isEqualToString:@"key1"]) {   //这里因为是自己手动实现的KVO，所以返回no，如果是非手动实现的KVO就直接调用父类实现
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key{
    NSLog(@"setValue: %@   %@",value,key);
}
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    NSLog(@" value: %@ , undefinedKey: %@",value, key);
//}

@end
