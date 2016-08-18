//
//  CBRecommendView.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/17.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit
//推荐显示
class CBRecommendView: UIView{
    //表格
    private var tbView:UITableView?
    //显示数据
    var model:CBRecommendModel?{
        didSet{
            //刷新表格
            tbView?.reloadData()
        }
    }
    
    init(){
        super.init(frame:CGRectZero)
        //创建表格视图
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        self.addSubview(tbView!)
        
        //约束
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:UITableView代理
extension CBRecommendView:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //广告的数据显示一个分组
        var sectionNum = 1
        if model?.data?.widgetList?.count > 0{
            sectionNum += (model?.data?.widgetList?.count)!
        }
        
        
        return sectionNum
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if  section == 0 {
            //广告的数据
            if model?.data?.banner?.count > 0{
                rowNum = 1
            }
        }else{
            //其他情况下面
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                rowNum = 1
            }else if listModel?.widget_type?.integerValue == WidgetType.RedPacket.rawValue{
                 //红包入口
                rowNum = 1
            }
            
        
        }
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0.0
        if indexPath.section == 0{
            //广告高度
            if model?.data?.banner?.count > 0{
                height = 160
            }
        }else{
            //其他情况下面
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                height = 80
            }else if listModel?.widget_type?.integerValue == WidgetType.RedPacket.rawValue{
                //红包入口
                height = 100
            }

        }
        
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.section == 0{
            //广告
            if model?.data?.banner?.count > 0{
                cell = CBRecommendADCell.createAdCellForTbView(tableView, atIndexPath: indexPath, withModel: model!)
            }
            
            return cell
        }else{
            //其他情况下面
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                cell = CBRecommendLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, withlistModel: listModel!)
            }else if listModel?.widget_type?.integerValue == WidgetType.RedPacket.rawValue{
                //红包入口
                cell = CBRedPacketCell.createRedPackageCellFor(tableView, atIndexPath: indexPath, withlistModel: listModel!)
            }
            
             return cell
            
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headView:UIView? = nil
        if  section>0{
            //其他情况下面
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                headView = CBSearchHeaderView.init(frame: CGRectMake(0,0,kSreenWith,44))
            }
        }
        
        return headView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height:CGFloat = 0.0
        if section > 0 {
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == WidgetType.GuessYouLike.rawValue{
                //猜你喜欢
                height = 44
            }
        }
        return height
    }
}
