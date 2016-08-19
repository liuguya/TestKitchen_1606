//
//  main.m
//  02_字符串
//
//  Created by 阳阳 on 16/8/18.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       //OC里面字符串分成不可变字符串和可变字符串
        //1.不可变字符串
        //NSSting
        NSString *str1 = [[NSString alloc] init];
        
        str1 = @"abc";
        //3)拼接
        str1 = [NSString stringWithFormat:@"%@,%@",@"hello",@"world"];
        //2)长度
        NSLog(@"%ld",str1.length);
        //3)获取某个字符
        char c = [str1 characterAtIndex:2];
        //4)字符串比较的方法
        NSString *str2 = @"abc";
        NSString *str3 = @"bbc";
        
       NSComparisonResult result = [str2 compare:str3];
        if (result == NSOrderedAscending){
            NSLog(@"小于");
        }else if (result == NSOrderedSame){
            NSLog(@"等于");
        }else if (result == NSOrderedDescending){
            NSLog(@"大于");
        }
        
        //5)以某个字符串开头
        NSString *str4 = @"abcdef";
        NSString *str5 = @"ab";
        BOOL ret = [str4 hasPrefix:str5];
        if (ret) {
            NSLog(@"包含前缀");
        }else{
            NSLog(@"不包含浅醉");
        }
        
        //6)后缀
        NSString *str6 = @"abcdef";
        NSString *str7 = @"ef";
        BOOL ret2 = [str6 hasSuffix:str7];
        if (ret2) {
            NSLog(@"包含后缀");
        }else{
            NSLog(@"不包含后醉");
        }
        
        //7)包含子串
        NSString *str8 = @"abcdef";
        NSString *str9 = @"ef";
        NSRange rang = [str8 rangeOfString:str9];
        if (rang.location != NSNotFound) {
            //表示包含子串
            NSLog(@"loc:%ld,len:%ld",rang.location,rang.length);
        }else{
            NSLog(@"不包含浅醉");
        }
        
        //8)首字母大写
        NSString *str10 = @"avc";
        NSString *ret3 = [str10 capitalizedString];
        NSLog(@"str10 = %@",ret3);
        
        //9)小写
        NSString *str11 = @"ABC";
        NSString *ret4 = [str11 lowercaseString];
        NSLog(@"str11 = %@",ret4);
        
        //10)全部大写
        NSString *str12 = @"avc";
        NSString *ret5 = [str12 uppercaseString];
        NSLog(@"str12 = %@",ret5);
        
        //2.可变字符串
        //NSMutableString:NSString
        
        //1)增加
        NSMutableString *muStr = [NSMutableString stringWithString:@"123"];
        [muStr appendString:@"456"];
        NSLog(@"%@",muStr);
        
        [muStr appendFormat:@"%@",@"hello"];
         NSLog(@"%@",muStr);
        //2)插入
        [muStr insertString:@"world" atIndex:8];
         NSLog(@"%@",muStr);
        //3)删除
        NSRange rangea = NSMakeRange(0, 5);
        [muStr deleteCharactersInRange:rangea];
        NSLog(@"%@",muStr);
        //4)修改
        
        [muStr setString:@"Object-c"];
        NSLog(@"%@",muStr);
        
        NSString *ret6 = [muStr stringByReplacingOccurrencesOfString:@"obj" withString:@"swift"];
        NSLog(@"%@",ret6);
        
    }
    return 0;
}
