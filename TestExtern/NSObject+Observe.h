//
//  NSObject+Observe.h
//  PracticeDemo
//
//  Created by mac on 2017/5/4.
//  Copyright © 2017年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SHObserverBlock)(id observer ,NSString *key ,id newValue, id oldValue);

@interface NSObject (Observe)


- (void)sh_addObserver:(NSObject *)observer forKey:(NSString *)key block:(SHObserverBlock)block;

@end
