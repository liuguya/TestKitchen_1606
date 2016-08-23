//
//  KTCSegmentCtrl.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/23.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class KTCSegmentCtrl: UIView {
    //重新实现初始化方法
    /**
     titleNames 显示文字的数组
     */
    var selectIndex:Int = 0
     init(frame: CGRect,titleNames: [String]) {
        super.init(frame: frame)
        if titleNames.count>0{
            let w = bounds.size.width/CGFloat(titleNames.count)
  
            
            for i in 0..<titleNames.count{
                let frame = CGRectMake(CGFloat(i)*w, 0, w, bounds.size.height)
                let btn = KTCSegmenrBtn(frame: frame)
                
                //btn.backgroundColor = UIColor.redColor()
                btn.confgTitle(titleNames[i])
                //点击事件
                btn.tag = 300+i
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                if i == 0{
                    btn.clicked = true
                }
                
                addSubview(btn)
            }
        
        }
        
    }
    
    func clickBtn(btn:KTCSegmenrBtn){
        
        if btn.tag != 300+selectIndex{
        
            //选中当前点击的按钮
            btn.clicked = true
            
            //取消上次选中的按钮
            let lasBtn = viewWithTag(300+selectIndex)
            if lasBtn?.isKindOfClass(KTCSegmenrBtn.self) == true{
                let lastSegBtn = lasBtn as! KTCSegmenrBtn
                lastSegBtn.clicked = false
            }
            selectIndex = btn.tag - 300
            
        }
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

}


class KTCSegmenrBtn:UIControl{
    private var label:UILabel?
    var clicked:Bool?{
        didSet{
            if clicked == true{
                //选中
                label?.textColor = UIColor.blackColor()
            
            }else{
                //取消选中
            label?.textColor = UIColor.grayColor()
            }
        }
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        
        //创建文字控件
        label = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(24), textAlignment: .Center, textColor: UIColor.grayColor())
        label?.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height-10)
        addSubview(label!)
    }
    
    func confgTitle(title:String){
        label?.text = title
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




