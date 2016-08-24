//
//  CBMaterialView.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/23.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBMaterialView: UIView {
    
    //表格
    private var tbView:UITableView?
    
    //数据
    var model:CBMaterialModel?{
        didSet{
            tbView?.reloadData()
        }
        
    }
    
    init() {
        super.init(frame: CGRectZero)
        //创建表格
        tbView = UITableView(frame: CGRectZero,style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        addSubview(tbView!)
        
        //添加约束
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
extension CBMaterialView:UITableViewDelegate,UITableViewDataSource{

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if model?.data?.data?.count > 0{
            rowNum = (model?.data?.data?.count)!
        }
        return rowNum
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var h:CGFloat = 0
        if model?.data?.data?.count > 0{
            let typeModel = model?.data?.data![indexPath.row]
             h = CBMaterialCell.heightWithModel(typeModel!)
        }
        
        return h
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "materialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBMaterialCell
        if nil == cell{
         cell = CBMaterialCell(style: .Default, reuseIdentifier: cellId)
        }
        let typeModel = model?.data?.data![indexPath.row]
        cell?.model = typeModel
        
        return cell!
    }
}
