//
//  CoderModel.h
//  PracticeDemo
//
//  Created by mac on 15/12/16.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoderModel : NSObject

@property(nonatomic, copy) NSString *key1;

-(instancetype)initCodeModelWith:(NSDictionary *)dic;
@end
