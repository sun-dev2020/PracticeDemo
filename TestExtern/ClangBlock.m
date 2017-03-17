//
//  ClangBlock.m
//  PracticeDemo
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 keyrun. All rights reserved.
//

#import <Foundation/Foundation.h>

int number = 10;

/* NSConcreteGlobalBlock  不引用外部变量 （全局静态block） */
void(^globalBlk)() = ^(){
    NSLog(@"hello");
};

/* NSConcreteMallocBlock  引用外部变量 （全局block ,isa 指向的还是global） */
void(^MallocBlk)(int) = ^(int num){
    NSLog(@" number = %d ",number);
};

void function (){
    /* NSConcreteStackBlock 函数返回时销毁 （栈block） */
    void(^blk)(NSString *) = ^(NSString *str){
        NSLog(@" print number %d",number);
    };
    number = 2;
    blk(@"");
    
    globalBlk();
    
}



/*
 objc.m文件  clang -rewrite-objc filePath  转成c语言文件.cpp

 
1.  block 捕捉局部变量   会在imp里保存一份变量拷贝 ，因此在block执行时 使用的时之前的值  而且变量不能被改变

2.  block 捕捉全局变量   直接可以在blk内部被引用  或者 更改

3.  block 捕捉被__block修饰的局部变量   会多生成一个结构体，里面会有isa指针 以及变量的指针__forwarding  变量可以在block中被修改
 
*/
