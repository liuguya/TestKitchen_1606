//
//  NSString+Reverse.m
//  01_category
//
//  Created by 阳阳 on 16/8/18.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

#import "NSString+Reverse.h"

@implementation NSString (Reverse)
-(NSString *)reverse{
    //@"abc"
    //OC里面可变字符串需要使用NSMutableString
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i=(int)self.length-1;i>=0;i--){
        //获取每一个字符
        char c = [self characterAtIndex:i];
        [result appendFormat:@"%c", c];
    
    }
    
    return result;
    
}


@end
