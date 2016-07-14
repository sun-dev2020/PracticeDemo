//
//  Person.h
//  
//
//  Created by mac on 16/1/27.
//
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCopying ,NSMutableCopying>

@property (nonatomic ,assign) BOOL sex;
@property (nonatomic ,copy) NSString *name;
@end
