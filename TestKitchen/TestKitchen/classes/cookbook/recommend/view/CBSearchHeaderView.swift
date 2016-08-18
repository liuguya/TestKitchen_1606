//
//  CBSearchHeaderView.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/18.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CBSearchHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //搜索框
        /*
        let searchBar = UISearchBar(frame: CGRectMake(40,0,bounds.size.width - 40*2,bounds.size.height))
         searchBar.la
        searchBar.placeholder = "输入菜名或食材搜索"
        self.backgroundColor = UIColor(white: 0.5, alpha: 0.4)
        searchBar.barTintColor = UIColor.whiteColor()
        addSubview(searchBar)*/
        let textField = UITextField(frame: CGRectMake(40, 4, bounds.size.width-40*2, bounds.size.height-4*2))
        textField.borderStyle = .RoundedRect
        textField.placeholder = "输入菜名或食材搜索"
        addSubview(textField)
        
        //左边搜索图片
        
        let imageVie = UIImageView.createImageView("search1")
        imageVie.frame = CGRectMake(3, 0, 20, 20)
        textField.leftView = imageVie
        textField.leftViewMode = .Always
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
