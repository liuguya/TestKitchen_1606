//
//  FCVideoCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/25.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class FCVideoCell: UITableViewCell {
    @IBOutlet weak var bgImageView: UIImageView!

    @IBAction func playVideo(sender: UIButton) {
        self.videoClosure!(model!.course_video!)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    //视频播放
    var videoClosure:(String->Void)?
    
    var model:FoodCourseSerialModel?{
        didSet{
            if model != nil{
                showData()
            }
            
        }
    }
    
    func showData(){
        let url = NSURL(string: (model!.course_image!))
        bgImageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        if model?.video_watchcount != nil{
            titleLabel.text = String(format: "%@人做过",(model?.video_watchcount)!)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
