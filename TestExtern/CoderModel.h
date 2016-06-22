//
//  CoderModel.h
//  PracticeDemo
//
//  Created by mac on 15/12/16.
//  Copyright (c) 2015年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;

@interface CoderModel : NSObject
{
    NSString *key1;
    
    @private
    Student *_student;
}
-(NSString *)key1;
-(void)setKey1:(NSString *)key;


@property(nonatomic, copy) NSString* information;
@property(nonatomic, strong) Student *student;
@property(nonatomic, assign) NSString* weakstr;
@property(nonatomic, assign) int wek;
//@property(nonatomic, copy) NSString *key1;

-(instancetype)initCodeModelWith:(NSDictionary *)dic;

-(id) init:(Student *)student;

@end
