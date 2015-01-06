//
//  ViewController.h
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *const constString =@"secend";   //常量指针  初始化完后不能再赋值，指向的对象可以是任意对象，对象可变 

const NSString *constString2 =@"constring2";  // 指向常量的指针 即指向别的常量，指针本身的值可修改，指向的值不能修改  ，赋值可变

extern const NSString *externConstString;    //声明全局变量     定义值之后值可变

static NSString *staticString =@"static";    //将变量的作用域限于本类    赋值可变

typedef enum {
    Isscroll =0,
    isforbidden
}Isallowed;

struct SSPoint {
    float x ;
    float y ;
    float z ;
};

typedef struct OtherPoing {
    int m ;
    int n ;
}OtherPoint;

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    OtherPoint oPoint;
}

@property (nonatomic,assign) Isallowed isallowornot;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

 
+(id)shareObject;
@end
