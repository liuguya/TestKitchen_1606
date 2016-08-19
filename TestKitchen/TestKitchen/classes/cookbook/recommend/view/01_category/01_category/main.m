//
//  main.m
//  01_category
//
//  Created by 阳阳 on 16/8/18.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Reverse.h"
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //OC里面给一个类型添加方法,可以使用Category分类和Extension扩展
        //分类只给类添加方法,不添加成员变量
        //我们一般可以用来给系统的类加一些方法
        //给一个系统的类添加方法的方式有几次和分类两种
        
        NSString *aStr = @"abcdefg";
        
        NSLog(@"%@",aStr.reverse);
        
        //扩展就是一个匿名的分类 一般不用
        Person *p = [[Person alloc] init];
        //扩展可以去写一些私有的方法
        [p eat];
   
    }
    return 0;
}
