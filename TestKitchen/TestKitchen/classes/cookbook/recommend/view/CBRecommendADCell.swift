//
//  CBRecommendADCell.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/17.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit
import Kingfisher
class CBRecommendADCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
    //属性
    
    var bannerArray:Array<CBRecommendBannerModel>?{
        didSet{
            self.scrollView.showsHorizontalScrollIndicator = false
            showData()
        }
    
    }
    
    func showData(){
        //删除之前的子视图
        for sub in scrollView.subviews{
            sub.removeFromSuperview()
        }
        let cnt = bannerArray?.count
        if cnt>0{
            //滚动视图添加一个容器
            let containerView = UIView.createView()
            scrollView.addSubview(containerView)
            //约束
            containerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.edges.equalTo((self?.scrollView)!)
                make.height.equalTo((self?.scrollView)!)
            })
            
            var lastView:UIView? = nil
            for i in 0..<cnt!{
                //1.获取模型对象
                let model = bannerArray![i]
                
                //循环创建图片
                let tmpImageView = UIImageView.createImageView(nil)
                
                let url = NSURL(string: model.banner_picture!)
                let image = UIImage(named: "sdefaultImage.png")
                tmpImageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                //添加约束
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kSreenWith)
                    if i == 0{
                        make.left.equalTo(containerView)
                    }else{
                        
                        make.left.equalTo((lastView?.snp_right)!)
                        
                    }
                    lastView = tmpImageView
                })
                
                
               
            }
            
            //修改容器视图的约束
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            scrollView.contentSize = CGSizeMake(kSreenWith*CGFloat(cnt!), 106)
            
            //修改分页控件
            self.pageControl.numberOfPages = cnt!
            scrollView.delegate = self
            scrollView.pagingEnabled = true
            
        }
        
    }
    
    class func createAdCellForTbView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:CBRecommendModel) -> CBRecommendADCell {
        
        let cellId = "recommendADCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendADCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendADCell", owner: nil, options: nil).last as? CBRecommendADCell
        }
        cell?.bannerArray = model.data?.banner
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

extension CBRecommendADCell:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        pageControl.currentPage = index
    }
}
