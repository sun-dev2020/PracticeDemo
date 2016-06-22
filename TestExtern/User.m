//
//  User.m
//  PracticeDemo
//
//  Created by mac on 16/2/18.
//  Copyright © 2016年 keyrun. All rights reserved.
//

#import "User.h"
#import <objc/runtime.h>
#import "MessageForwarding.h"
//#import <sys/ptrace.h>
static NSMutableArray *mArray ;
static int count;
@implementation User

+(User *)shareUser{
    static dispatch_once_t onceToken;
    static User *user = nil;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] initPrivateMethod];
        mArray = [[NSMutableArray alloc] initWithArray:@[@"A",@"B"]];
    });
    return user;
}
- (id)initPrivateMethod{
    self = [super init];
    return self;
}

-(void)insertObj:(NSString *)obj index:(NSInteger)index{
    if (obj != nil) {
        [mArray insertObject:obj atIndex:index];
     
    }
}

-(void)deleteObjIndex:(NSInteger)index{
    if (mArray.count > index) {
        @synchronized(mArray) {
           [mArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:index]];
//            sleep(1);
            NSLog(@" delete %@ ",mArray);
        }
    }
}

-(NSMutableArray *)getMArray{
    return mArray;
}

//////Runtime

//正常调用
//-(void)sendMessage:(NSString *)word{
//    
//}
//当对象在类对象继承体系中没有找到sendMessage后，会有3次机会拯救
//1.Method Resolution
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(sendMessage:)) {
        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self ,NSString *word){
            NSLog(@" method resolution way : %@ ",word);
        }), "sad");
    }
    return YES;
}

//2.Fast Forwarding     此方法返回不是nil或self，也会重启消息发送，把消息转发给另外一个类对象处理，这里准备一个MessageForwarding 类
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(sendMessage:)) {
        return [MessageForwarding new];
    }
    return nil;
}

//3.Normal Forwarding   此方法来获取方法的参数和返回值，如果返回nil，就抛出异常unrecognized selector sent to instance，如果返回签名函数就会创建一个NSInvocation对象调用-forwardInvocation:方法
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return signature;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation{   //将消息转给预先的处理类messageForwarding
    MessageForwarding *messageForwarding = [MessageForwarding new];
    if ([messageForwarding respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:messageForwarding];
    }
}

@end
