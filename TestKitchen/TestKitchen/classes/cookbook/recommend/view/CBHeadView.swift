//
//  CBHeadView.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/19.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBHeadView: UIView {
    //标题
    private var titleLabel:UILabel?
    private var imageView:UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //背景视图
        let bgView = UIView.createView()
        bgView.frame = CGRectMake(0, 10, bounds.size.width,bounds.size.height-10)
        bgView.backgroundColor = UIColor.whiteColor()
        
        //标题文字
        //100 + 30
        let titlW:CGFloat = 100
        let imageW:CGFloat = 30
        let  x = (bounds.size.width - titlW - imageW)/2
        titleLabel = UILabel.createLabel(nil, font: UIFont.boldSystemFontOfSize(20), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.frame = CGRectMake(x, 10, titlW, bounds.size.height - 10)
        addSubview(titleLabel!)
        
        //右边图片
        imageView = UIImageView.createImageView("more_icon")
        imageView?.frame = CGRectMake(x+titlW, 10, imageW, imageW)
        addSubview(imageView!)
        
        
        
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        
        
        
        
        
    }
    
    
   func configTitle(title:String){
       titleLabel?.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
