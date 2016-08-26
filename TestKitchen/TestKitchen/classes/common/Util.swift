//
//  Util.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/18.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

//这个文件用来定义枚举
//食材首页推荐的数据类型
public enum WidgetType:Int{
    case GuessYouLike = 1  //猜你喜欢
    case RedPacket = 2     //红包入口
    case NewProduct = 5    //今日新品
    case Special = 3       //早餐日记健康100岁
    case Scene = 9
    case Talent = 4        //推荐达人
    
    case Works = 8          //精选作品
    
    case Subject = 7        //专题
    
}

//2.食材首页推荐的cell的点击事件闭包的类型
/*
 第一个参数是标题文字
 第二个参数是link字符串
 
 */
public typealias CBCellClosure = (String?,String)->Void


