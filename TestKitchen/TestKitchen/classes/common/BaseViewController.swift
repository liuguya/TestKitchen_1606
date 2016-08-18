//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/15.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //导航标题
    func addNavTitle(title:String?){
        let titleLabel = UILabel.createLabel(title, font: UIFont.systemFontOfSize(24), textAlignment: .Center, textColor: UIColor.blackColor())
        
        navigationItem.titleView = titleLabel
    }
    
    //导航按钮
    func addNavBtn(imageName:String,target:AnyObject?,action:Selector,isLeft:Bool){
        let  btn = UIButton.createButton(nil, bgImageName: imageName, selectBgImageName: nil, target: target, action: action)
        btn.frame = CGRectMake(0, 4, 30, 30)
        let  barItem = UIBarButtonItem(customView: btn)
        if  isLeft {
            navigationItem.leftBarButtonItem = barItem
        }else{
            navigationItem.rightBarButtonItem = barItem
        }
        
        
    }
    
    func addNavBackBtn(){
        addNavBtn("", target: self, action: #selector(backAction), isLeft: true)
    }
    func backAction(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
