//
//  NSObject+Observe.m
//  PracticeDemo
//
//  Created by mac on 2017/5/4.
//  Copyright © 2017年 keyrun. All rights reserved.
//

#import "NSObject+Observe.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface KVOModel : NSObject

@property (nonatomic ,copy) NSString *key;
@property (nonatomic ,weak) NSObject *object;
@property (nonatomic ,copy) SHObserverBlock block;


@end


@implementation KVOModel

- (instancetype)initKVOModelWithObserver:(NSObject *)obj  key:(NSString *)key complete:(SHObserverBlock)block
{
    self = [super init];
    if (self) {
        _key = key;
        _object = obj;
        _block = [block copy];
    }
    return self;
}

@end


static Class kvo_class(id self , SEL _cmd){
    return class_getSuperclass(object_getClass(self));
}
static NSString * getterForSetter(NSString *setter){
    if (setter.length < 1 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]){
        return nil;
    }
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    NSString *word = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:word];
    return key;
}

static void kvoSetterImp(id self , SEL _cmd , id newValue){
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        return;
    }
    
    id oldValue = [self valueForKey:getterName];
    
    // 调用原来的方法实现
    struct objc_super superClass = {
        .receiver =  self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    void (*objc_msgSendSuperCasted)(void * , SEL , id) = (void *)objc_msgSendSuper;
    objc_msgSendSuperCasted(&superClass , _cmd , newValue);
    
    NSMutableArray *allObservers = objc_getAssociatedObject(self, "kvoObservers");
    for (KVOModel *model in allObservers) {
        if ([model.key isEqualToString:getterName]) {
            model.block(self , getterName, newValue ,oldValue);
        }
    }
}


@implementation NSObject (Observe)


-(void)sh_addObserver:(NSObject *)observer forKey:(NSString *)key block:(SHObserverBlock)block{
    
    SEL setterSel = NSSelectorFromString([self getKeySetterMethod:key]);   //拿到要监听的属性setter方法名
    Method setterMethod = class_getInstanceMethod([self class], setterSel);
    
    if (!setterMethod) {
        return;
    }
    
    Class oriClass = object_getClass(self);
    NSString *className = NSStringFromClass(oriClass);
    
    if (![className hasPrefix:@"SHKvoclass_"]) {
        oriClass = [self makeKvoClassWithOriginalClassName:className];   //注册kvo派生类
        object_setClass(self, oriClass);    //将对象的isa指向新的类
    }
    
    if (![self hasSelector:setterSel]) {     //检查派生类 是否有实现该方法（一般是没有的，派生类还在内存中）
        const char *types = method_getTypeEncoding(setterMethod);
        class_addMethod(oriClass, setterSel, (IMP)kvoSetterImp, types);   //添加对改方法的实现
    }
    
    //保存监听对象
    KVOModel *model = [[KVOModel alloc] initKVOModelWithObserver:self key:key complete:block];
    NSMutableArray *allObservers = objc_getAssociatedObject(self, "kvoObservers");
    if (!allObservers) {
        allObservers = [NSMutableArray array];
        objc_setAssociatedObject(self, "kvoObservers", allObservers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [allObservers addObject:model];
    
}

- (Class)newKVOClassWithOriClassName:(NSString *)oriName{
    NSString *kvoClassName = [@"SHKvoclass_" stringByAppendingString:oriName];
    Class cls = NSClassFromString(kvoClassName);
    if (cls) {
        return cls;
    }
    
    Class oriClass = object_getClass(self);
    Class kvoClass = objc_allocateClassPair(oriClass, kvoClassName.UTF8String , 0);
    
    Method classMethod = class_getInstanceMethod(oriClass, @selector(class));
    const char *types = method_getTypeEncoding(classMethod);
    class_addMethod(kvoClass, @selector(class), (IMP)kvo_class, types);
    objc_registerClassPair(kvoClass);
    
    return kvoClass;

}
- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalClazzName
{
    NSString *kvoClazzName = [@"SHKvoclass_" stringByAppendingString:originalClazzName];
    Class clazz = NSClassFromString(kvoClazzName);
    
    if (clazz) {
        return clazz;
    }
    
    // class doesn't exist yet, make it
    Class originalClazz = object_getClass(self);
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    
    // grab class method's signature so we can borrow it
    Method clazzMethod = class_getInstanceMethod(originalClazz, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    
    objc_registerClassPair(kvoClazz);
    
    return kvoClazz;
}


- (NSString *)getKeySetterMethod:(NSString *)key{
    if (key.length < 1) {
        return nil;
    }
    NSString *upString = [[key substringToIndex:1] uppercaseString];
    NSString *resetString = [key  substringFromIndex:1];
    return [NSString stringWithFormat:@"set%@%@:", upString, resetString];
}


- (BOOL)hasSelector:(SEL)selector{
    Class  class = object_getClass(self);
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    
    for (unsigned int i = 0; i < count; i++) {
        SEL aSelector = method_getName(methodList[i]);
        if (aSelector == selector) {
            return YES;
        }
    }
    return NO;
}





@end


