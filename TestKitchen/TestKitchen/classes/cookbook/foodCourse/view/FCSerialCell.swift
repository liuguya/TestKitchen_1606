//
//  FCSerialCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/26.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

protocol FCSerialCellDelegate:NSObjectProtocol {
    func didSelectSerialAtIndex(index:Int)
    /*修改展开和收起的状态*/
    func changeExpandState(isExpand:Bool)
}

class FCSerialCell: UITableViewCell {
    //更多按钮
    private var moreBtn:UIButton?
    //当前集数展开还是合起
     var isExpand:Bool = false
    //代理
    var delegate:FCSerialCellDelegate?
    
    //选中按钮的序号
    var selectIndex:Int = 0{
        didSet{
            selectBtnAtIndex(selectIndex, lastIndex: oldValue)
        }
    }
    var num:Int?{
        didSet{
            if num>0{
                showData()
            }
        }
    }
    private var w:CGFloat{
        get {
            return 40
        }
    }
    
    private var h:CGFloat{
        get {
            return 40
        }
    }
    private var spaceY:CGFloat{
        get {
            return 10
        }
    }
     var margin:CGFloat{
        get {
            return 20
        }
    }

//显示数据
   func showData(){
    for old in contentView.subviews{
        old.removeFromSuperview()
    }
  
    //每一行的按钮
    let rowNum = Int((kSreenWith - margin*2)/w)
    //横向间距
    let spaceX = (kSreenWith-margin*2 - CGFloat(rowNum)*w)/(CGFloat(rowNum-1))
    
        var cnt = num!
    if num > rowNum*2{
        //超过两行,要判断是否展开
        if isExpand == false{
            //如果没有展开
            cnt = rowNum*2
        }
    }
    
        for i in 0..<cnt{
            let row = i/rowNum
            let col = i%rowNum
            let frame = CGRectMake(margin+(spaceX+w)*CGFloat(col), spaceY+(spaceY+h)*CGFloat(row), w, h)
            
            let btn = FCSerialBtn(frame: frame, index: i+1)
            btn.tag = 500+i
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            
            contentView.addSubview(btn)
        }
    
        //判断添加展开按钮
        if num > rowNum*2 {
            var imageName = "pull.png"
            var btnBow:CGFloat = 2
            if isExpand == true{
                btnBow = CGFloat(num!/rowNum)
                if num! % rowNum > 0 {
                    btnBow += 1
                }
                imageName = "push.png"
            }
            moreBtn = UIButton.createButton(nil, bgImageName: imageName, selectBgImageName: nil, target: self, action: #selector(expandAction))
            moreBtn?.frame = CGRectMake((kSreenWith-54)/2, margin+(h+spaceY)*btnBow, 54, 30)
            contentView.addSubview(moreBtn!)
        }
    }
    
    
    func expandAction(){
            print("11")
            //修改展开和收起的状态
            delegate?.changeExpandState(!isExpand)
            self.isExpand = !isExpand

    }
    
    
    //计算cell的高度
    /**
     num 一共有多少集
     isExpand 状态
     */
    class func heightWithNum(num:Int,isExpand:Bool?)->CGFloat{

        //每一行的按钮
        //var cell = FCSerialCell()
        let rowNum = Int((kSreenWith - 20*2)/40)
        
        //计算一共有几行
        var rows = num/rowNum
        if num%rowNum > 0{
         rows+=1
        }
        
        var h:CGFloat?
        //如果num 大于并且是合起
        if (num > rowNum*2) && (isExpand == false){
            h = 20+CGFloat(2)*(40+10)+30
        }else{
            h = 20+CGFloat(rows)*(40+10)+30
        }
        
    
        return h!
    }
    
    func clickBtn(btn:FCSerialBtn){
        //修改当前cell的ui
        selectIndex = btn.tag - 500
        delegate?.didSelectSerialAtIndex(selectIndex)
    }
    
    //点击按钮时修改ui
    func selectBtnAtIndex(index:Int,lastIndex:Int){
        let lastBtn = contentView.viewWithTag(500+lastIndex)
        if lastBtn?.isKindOfClass(FCSerialBtn.self) == true{
            let btn = lastBtn as! FCSerialBtn
            btn.clicked = false
        }
        
        let curBtn = contentView.viewWithTag(500+index)
        if curBtn?.isKindOfClass(FCSerialBtn.self) == true{
            let btn = curBtn as! FCSerialBtn
            btn.clicked = true
        }
        
        
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class FCSerialBtn:UIControl{
    var titleLabel:UILabel?
    var clicked:Bool = false{
        didSet{
            if clicked == true{
                //选中
                backgroundColor = UIColor.orangeColor()
                titleLabel?.textColor = UIColor.whiteColor()
            }else if clicked == false{
                backgroundColor = UIColor(white: 0.9, alpha: 1.0)
                titleLabel?.textColor = UIColor.grayColor()
            
            }
        }
    }
    init(frame: CGRect,index:Int) {
        super.init(frame: frame)
        
        //文字
        titleLabel =
            UILabel.createLabel("\(index)", font: UIFont.systemFontOfSize(12), textAlignment: .Center, textColor: UIColor.grayColor())
        titleLabel?.frame = bounds
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        addSubview(titleLabel!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
