//
//  CBRecommendLikeCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/17.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBRecommendLikeCell: UITableViewCell {

    
   
    @IBAction func clickBtn(sender: UIButton) {
        print("1")
    }
    
    
    //显示数据
    var model:CBRecommendWidgetListModel? {
        didSet{
            //显示图片和文字
            showData()
        }
    }
    func showData(){
        for var i in 0..<8{
            //图片
            if model?.widget_data?.count > i{
                let imageModel = model?.widget_data![i]
                if imageModel?.type == "image"{
                    //获取图片视图
                    //tag: 200 201 202 203
                    let index = i/2
                    let subView = self.contentView.viewWithTag(200+index)
                    //判断类型
                    if (subView?.isKindOfClass(UIImageView.self)) == true{
                        let imageView = subView as! UIImageView
                        let url = NSURL(string: (imageModel?.content!)!)
                        let image = UIImage(named: "sdefaultImage")
                        imageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }
            
            
            //文字
            if model?.widget_data?.count > i+1{
                let textModel = model?.widget_data![i+1]
                if textModel?.type == "text"{
                    //tag 300 301 302 303
                    let subView = self.contentView.viewWithTag(300+i/2)
                    if (subView?.isKindOfClass(UILabel.self)) == true{
                        //print(textModel?.content!)
                        let label = subView as! UILabel
                        label.text = textModel?.content!
                    }
                }
            }
            
            //每次遍历2个
            i += 1
            
        }
    }
    
    //创建cell的方法
    
    class func createLikeCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withlistModel listModel:CBRecommendWidgetListModel) -> CBRecommendLikeCell{
            //猜你喜欢
            let cellId = "recommendLikeCellId"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendLikeCell
            
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("CBRecommendLikeCell", owner: nil, options: nil).last as? CBRecommendLikeCell
            }
            cell?.model = listModel
            return cell!
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
