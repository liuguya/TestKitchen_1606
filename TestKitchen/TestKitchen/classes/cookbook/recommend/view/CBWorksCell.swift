//
//  CBWorkCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/22.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBWorksCell: UITableViewCell {

    @IBAction func clickBtn(sender: UIButton) {
    }

    @IBAction func clickUserBtn(sender: UIButton) {
    }
    
    
    
    var model:CBRecommendWidgetListModel?{
        didSet{
            showData()
        
        }
    
    }
    
    func showData(){
        //1表示列的序号
        for i in 0..<3{
            //i 0  1  2
            
            //大图片
            //0  3 6
            if model?.widget_data?.count > i*3{
                let imageModel = model?.widget_data![i*3]
                if imageModel?.type == "image"{
                    let subView = contentView.viewWithTag(100+i)
                    if ((subView?.isKindOfClass(UIButton.self)) == true){
                        let sceneBtn = subView as! UIButton
                        let url = NSURL(string: (imageModel?.content)!)
                        
                        let dImage = UIImage(named: "sdefaultImage")
                        sceneBtn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }

                
                }
            }
            
            
            //用户图片
            /**
             1 4
             */
            if model?.widget_data?.count > i*3+1{
                let imageModel = model?.widget_data![i*3+1]
                if imageModel?.type == "image"{
                    let subView = contentView.viewWithTag(200+i)
                    if ((subView?.isKindOfClass(UIButton.self)) == true){
                        let sceneBtn = subView as! UIButton
                        sceneBtn.layer.cornerRadius = 20
                        let url = NSURL(string: (imageModel?.content)!)
                        
                        let dImage = UIImage(named: "sdefaultImage")
                        sceneBtn.kf_setBackgroundImageWithURL(url, forState: .Normal, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                    
                    
                }
            }
            //用户名
            
            //2 5 8
            if model?.widget_data?.count > i*3+2{
                let nameModel = model?.widget_data![i*3+2]
                if nameModel?.type == "text"{
                    let subView = contentView.viewWithTag(300+i)
                    if subView?.isKindOfClass(UILabel.self) == true{
                        let nameLabel = subView as! UILabel
                        nameLabel.text = nameModel?.content!
                    }
                }
            }
            
            
            
            
        }
        let subView = contentView.viewWithTag(400)
        if subView?.isKindOfClass(UILabel.self) == true{
            let descLabel = subView as! UILabel
            descLabel.text = model?.desc
        }
    }
    
    
    //创建cell方法
    class func createWorkCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withlistModel listModel:CBRecommendWidgetListModel) -> CBWorksCell{
        //滚动视图
        let cellId = "WorkCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBWorksCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBWorkCell", owner: nil, options: nil).last as? CBWorksCell
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
