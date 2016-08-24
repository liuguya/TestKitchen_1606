//
//  KTCSegmentCtrl.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/23.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

protocol KTCSegmentCtrlDelegate:NSObjectProtocol {
    func didSelectSegCtrl(segCtrl:KTCSegmentCtrl,aIndex index:Int)
}

class KTCSegmentCtrl: UIView {
    //重新实现初始化方法
    /**
     titleNames 显示文字的数组
     */
    var selectIndex:Int = 0{
        didSet{
            if selectIndex != oldValue{
                selecBtnAtIndex(selectIndex, lastIndex: oldValue)
            }
            
        }
    
    }
    //下划线视图
    private var lineView:UIView?
    
    //代理属性
   weak var delegate:KTCSegmentCtrlDelegate?
    
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
            
            lineView = UIView.createView()
            lineView?.backgroundColor = UIColor.orangeColor()
            lineView?.frame = CGRectMake(0,bounds.size.height-2, w, 2)
            addSubview(lineView!)
        
        }
        
    }
    
    func clickBtn(btn:KTCSegmenrBtn){
        
        if btn.tag != 300+selectIndex{
            
            //1.修改UI
            selectIndex = btn.tag - 300
            
            //2其他操作
            delegate?.didSelectSegCtrl(self, aIndex: selectIndex)
           
        }
        
      
    }
    
    /**
     
     index 是当前选中的序号
     lastIndex是上次选中的序号
     */
    func selecBtnAtIndex(index:Int,lastIndex:Int){
        
            
            //选中当前点击的按钮
            let curBtn = viewWithTag(300+index)
        if curBtn?.isKindOfClass(KTCSegmenrBtn.self) == true{
            let btn = curBtn as! KTCSegmenrBtn
            btn.clicked = true
        }
        
            //取消上次选中的按钮
            let lasBtn = viewWithTag(300+lastIndex)
            if lasBtn?.isKindOfClass(KTCSegmenrBtn.self) == true{
                let lastSegBtn = lasBtn as! KTCSegmenrBtn
                lastSegBtn.clicked = false
                
            }
        
            
            lineView?.frame.origin.x = (lineView?.bounds.size.width)! * CGFloat(index)

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




