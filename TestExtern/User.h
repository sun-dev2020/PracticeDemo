//
//  User.h
//  PracticeDemo
//
//  Created by mac on 16/2/18.
//  Copyright © 2016年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+(User *)shareUser;

-(void)insertObj:(NSString *)obj index:(NSInteger)index;

-(void)deleteObjIndex:(NSInteger)index;

-(NSMutableArray *)getMArray;


-(void)sendMessage:(NSString *)word;

@end
