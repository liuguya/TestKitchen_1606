//
//  CBRecommendNewCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/19.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBRecommendNewCell: UITableViewCell {
    //点击进详情
    
    @IBAction func clickBtn(sender: UIButton) {
    }
 
    
    
    @IBAction func playAction(sender: UIButton) {
    }
    
    var model:CBRecommendWidgetListModel?{
        didSet{
            showData()
        }
    }
    
    func showData(){
        for i in 0..<3{
            //图片
            //0 4 8 12
            if model?.widget_data?.count > i*4{
                let imageModel = model?.widget_data![i*4]
                if imageModel?.type == "image"{
                    let url = NSURL(string: (imageModel?.content)!)
                    
                    let dImage = UIImage(named: "sdefaultImage")
                    
                    //获取图片视图
                    let subView = contentView.viewWithTag(200+i)
                    if ((subView?.isKindOfClass(UIImageView.self)) == true){
                        let imageView = subView as! UIImageView
                        imageView.kf_setImageWithURL(url, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }
            //视频
            //1 5 9
            //标题文字
            //2 6 10 14
            if model?.widget_data?.count > i*4+2{
                let titleModel = model?.widget_data![i*4+2]
                if titleModel?.type == "text"{
                    //获取标题的label
                    let subView = contentView.viewWithTag(400+i)
                    if ((subView?.isKindOfClass(UILabel.self)) == true){
                        let titleLabel = subView as! UILabel
                        titleLabel.text = titleModel?.content!
                    }
                }
            }
            //描述文字
            
            if model?.widget_data?.count > i*4+3{
                let descModel = model?.widget_data![i*4+3]
                if descModel?.type == "text"{
                    //获取标题的label
                    let subView = contentView.viewWithTag(500+i)
                    if ((subView?.isKindOfClass(UILabel.self)) == true){
                        let descLabel = subView as! UILabel
                        descLabel.text = descModel?.content!
                    }
                }
            }
        
        }
    }
    
    
    //创建cell的方法
    class func createNewCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withlistModel listModel:CBRecommendWidgetListModel) -> CBRecommendNewCell{
        //滚动视图
        let cellId = "recommendNewCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendNewCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendNewCell", owner: nil, options: nil).last as? CBRecommendNewCell
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
