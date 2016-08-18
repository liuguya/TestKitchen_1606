//
//  CBRedPacketCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/18.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBRedPacketCell: UITableViewCell {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //显示数据
    var model:CBRecommendWidgetListModel?{
        didSet{
            self.scrollView.showsHorizontalScrollIndicator = false
            showData()
        }
    }
    
    func showData(){
        //1.容器视图
        let container = UIView.createView()
        scrollView.addSubview(container)
        //约束
        container.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView)
            make.height.equalTo(self!.scrollView.snp_height)
        }
        
        //循环添加图片
        var lastView:UIView? = nil
        let cnt = model?.widget_data?.count
        if cnt > 0{
            for i in 0..<cnt!{
                let imageModel = model?.widget_data![i]
                //显示图片
                let imageView = UIImageView.createImageView(nil)
                if imageModel?.type == "image"{
                    let url = NSURL(string: (imageModel?.content!)!)
                    let image = UIImage(named: "sdefaultImage")
                    imageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    container.addSubview(imageView)
                    imageView.snp_makeConstraints(closure: { (make) in
                        make.top.bottom.equalTo(container)
                        make.width.equalTo(180)
                        if i == 0{
                            make.left.equalTo(0)
                        }else{
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                    })
                    //点击事件
                    imageView.userInteractionEnabled = true
                    imageView.tag = 400+i
                    let g = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
                    imageView.addGestureRecognizer(g)
                    
                    
                    lastView = imageView
                }
                
            }
            
           
            
           //修改容器大小
            container.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
                
            })
            
        }
        
        
        
    }
    
    //手势
    func tapAction(g:UITapGestureRecognizer){
        let inde = (g.view?.tag)! - 400
        print(inde)
    }
    
    
    //创建cell的方法
    class func createRedPackageCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withlistModel listModel:CBRecommendWidgetListModel) -> CBRedPacketCell{
        //滚动视图
        let cellId = "redPacketCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRedPacketCell
        
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRedPacketCell", owner: nil, options: nil).last as? CBRedPacketCell
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
