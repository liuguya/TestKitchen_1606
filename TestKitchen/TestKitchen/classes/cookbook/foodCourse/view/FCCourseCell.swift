//
//  FCCourseCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/26.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class FCCourseCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    
    @IBOutlet weak var heightCon: NSLayoutConstraint!
 
    
    //显示数据
    var model:FoodCourseSerialModel?{
        didSet{
            showData()
        }
    }
    
    func showData(){
        //标题
        nameLabel.text = model?.course_name!
        
        //描述文字
        if model?.course_subject != nil{
            subjectLabel.text = model?.course_subject!
            let dict = [NSFontAttributeName:UIFont.systemFontOfSize(17)]
            let h = NSString(string: (model!.course_subject)!).boundingRectWithSize(CGSizeMake(kSreenWith-20*2, 1000), options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
            //只要是小数,整数部分
            self.heightCon.constant = CGFloat(Int(h))+1
        }
        
        
        
    }
    
    class func heightWithModel(model:FoodCourseSerialModel)->CGFloat {
        
        let titleH:CGFloat = 20
        let my:CGFloat = 10
        
        var height:CGFloat = titleH+my
        let dict = [NSFontAttributeName:UIFont.systemFontOfSize(17)]
        let h = NSString(string: (model.course_subject)!).boundingRectWithSize(CGSizeMake(kSreenWith-20*2, 1000), options: .UsesLineFragmentOrigin, attributes: dict, context: nil).size.height
        height += CGFloat(Int(h))+1+my
        
        return height
        
        
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
