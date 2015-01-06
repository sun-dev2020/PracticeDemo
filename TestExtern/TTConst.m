//
//  TTConst.m
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "TTConst.h"

static TTConst *tconst = nil;

@implementation TTConst

+(TTConst *)shareTTConst{      //GCD 实现单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tconst = [[TTConst alloc] init];
    });
    return tconst ;
}

-(instancetype)init{
    self = [super init];
    if (self) {
                     //初始化
    }
    return self ;
}

+(TTConst *)defaultTTConst{    //synchronized 实现单例
    @synchronized(self){
        if (tconst == nil) {
            tconst =[[TTConst alloc] init];
        }
    }
    return tconst ;
}

@end
