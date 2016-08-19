//
//  Person.m
//  01_category
//
//  Created by 阳阳 on 16/8/18.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

#import "Person.h"
@interface Person(){
    NSString *_gender;
}
//@property (nonatomic,assign)int age;
//-(void)eat;
@end
@implementation Person

-(void)eat{
    _gender = @"male";
    self.age = 20;
    NSLog(@"age = %d",self.age);
    NSLog(@"某个人在吃饭");
}

@end
