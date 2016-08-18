//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/15.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var bgView:UIView?
    
    
    //json文件对应的数组
    private var array:Array<Dictionary<String,String>>?{
        get{
            //读取文件
            let path = NSBundle.mainBundle().pathForResource("Ctrl", ofType: "json")
            
            var myArray:Array<Dictionary<String,String>>? = nil
            if let filePath = path{
               let data = NSData(contentsOfFile: filePath)
                if let jsonData = data{
                    do {
                       let jsonValue = try  NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                        
                        if jsonValue.isKindOfClass(NSArray.self){
                            myArray = jsonValue as? Array<Dictionary<String,String>>
                        }
                    }catch{
                        //程序出现异常
                        print(error)
                        return nil
                    }
                    
                }
                
            }
            return myArray
        }
    }
    
//数组类型解json
//    private var array:Array<Dictionary<String,String>>?{
//        get{
//            //读取文件
//            let path = NSBundle.mainBundle().pathForResource("Ctrl", ofType: "json")
//            
//            var myArray:Array<Dictionary<String,String>>? = nil
//            if let filePath = path{
//                let tmpArray = NSArray(contentsOfFile: filePath)
//                myArray = tmpArray as? Array<Dictionary<String,String>>
//            }
//            return myArray
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
      //Swift里面,一般在类的内部调用属性和方法的时候,可以不写self,一般在闭包里面写self
      //创建视图控制器
      createViewControllers()
    }
    
    //创建视图控制器
    func createViewControllers(){
        var ctrlNames = [String]()
        var imageNames = [String]()
        var titleNames = [String]()
        
//        if let tmpArray = self.array{
//            for dict in tmpArray{
//                let name = dict["ctrlName"]
//                let imageName = dict["imageName"]
//                ctrlNames.append(name!)
//                imageNames.append(imageName!)
//                
//                let titleName = dict["titleName"]
//                titleNames.append(titleName!)
//            }
//        }else{
            ctrlNames = ["CookbookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            titleNames =  ["食材","社区","商城","食课","我的"]
            imageNames = ["home","community","shop","shike","mine"]
            self.customTabbar(titleNames, imageNames: imageNames)
        //}
      
            
        
        var vCtrlArray = Array<UINavigationController>()
        
        
        
        for i in 0..<ctrlNames.count{
            //创建视图控制器
            let ctrlName = "TestKitchen." + ctrlNames[i]
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            //导航
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
        }
        self.viewControllers = vCtrlArray
    }
    
    //自定制tabbar
    func customTabbar(titleNames:[String],imageNames:[String]){
        //背景视图
        bgView = UIView.createView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(bgView!)
        //添加约束
        bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
            
        })
        //2.循环添加按钮
        //按钮的宽度
        let width = kSreenWith/5.0
        
        for i in 0..<imageNames.count{
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            
            //1.按钮
            let bgImageName = imageName+"_normal"
            let selectBgImageName = imageName+"_select"
            let btn = UIButton.createButton(nil, bgImageName: bgImageName, selectBgImageName: selectBgImageName, target: self, action: #selector(clickBtn(_:)))
            
            view.addSubview(btn)
            //添加约束
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
            })
            
            //2.2显示文字
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: .Center, textColor: UIColor.grayColor())
            btn.addSubview(label)
            //添加约束
            label.snp_makeConstraints(closure: {
                (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
            })
            btn.tag = 1000+i
            label.tag = 2000
            
            //默认选中第一个按钮
            if i == 0{
                btn.selected = true
                label.textColor = UIColor.brownColor()
            }
        }
        
    }
    
    //点击事件
    func clickBtn(btn:UIButton){
        //1.取消之前选中按钮的状态
        let lastBtnView = view.viewWithTag(1000+selectedIndex)
        if let tmpBtn = lastBtnView{
            let lastBtn = tmpBtn as! UIButton
            let lastLabel = tmpBtn.viewWithTag(2000)
            if let tmpLabel = lastLabel{
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        }
        
        //2.设置当前选中的按钮
        let  curLabelView = btn.viewWithTag(2000)
        if let tmpLabel = curLabelView{
            let  curLabel = tmpLabel as! UILabel
            btn.selected = true
            curLabel.textColor = UIColor.brownColor()
        }
        //3.选中视图控制器
        selectedIndex = btn.tag-1000
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
