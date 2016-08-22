//
//  CBTalentCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/22.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBTalentCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var talentImageView: UIImageView!
   
    @IBOutlet weak var fansLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    

    
    var dataArray:Array<CGRecommendWidgetDataModel>? {
        didSet{
            
            showData()
        
        }
    }
    
    func  showData(){
        //图片
        if dataArray?.count>0{
            let imageModel = dataArray![0]
            if imageModel.type == "image"{
                let url = NSURL(string: imageModel.content!)
                let dImage = UIImage(named: "sdefaultImage")
                talentImageView.kf_setImageWithURL(url, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        
        //名字
        if dataArray?.count>1{
            let nameModel = dataArray![1]
            if nameModel.type == "text"{
                nameLabel.text = nameModel.content!
            }
        }
        //描述文字
        if dataArray?.count>2{
            let descModel = dataArray![2]
            if descModel.type == "text"{
                descLabel.text = descModel.content!
            }
        }
        //粉丝数
        if dataArray?.count>3{
            let fansModel = dataArray![3]
            if fansModel.type == "text"{
                fansLabel.text = fansModel.content!
            }
        }
        
    }
    
    
    //显示cell
    class func CBTalentCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withlistModel listModel:CBRecommendWidgetListModel) -> CBTalentCell{
        //滚动视图
        let cellId = "talentCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBTalentCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBTalentCell", owner: nil, options: nil).last as? CBTalentCell
        }
        //indexPath.row*4 ,4
        //防止越界
        if listModel.widget_data?.count > indexPath.row*4+3{
            
        
            let array =  NSArray(array: listModel.widget_data!)
            let curArray = array.subarrayWithRange(NSMakeRange(indexPath.row*4, 4))
            cell?.dataArray = curArray as? Array<CGRecommendWidgetDataModel>
        
        }
       //cell?.dataArray = listModel
        return cell!
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
