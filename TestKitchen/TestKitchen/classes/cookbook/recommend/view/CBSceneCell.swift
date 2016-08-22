//
//  CBSceneCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/22.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBSceneCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    

    func  config(title:String){
        nameLabel.text = title
    }
    
    class func createSceneCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withlistModel listModel:CBRecommendWidgetListModel) -> CBSceneCell{
        //滚动视图
        let cellId = "scenneCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBSceneCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBSceneCell", owner: nil, options: nil).last as? CBSceneCell
        }
        cell?.config(listModel.title!)
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
