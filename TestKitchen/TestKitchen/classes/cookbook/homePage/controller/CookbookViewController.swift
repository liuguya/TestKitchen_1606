//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/15.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {
    //滚动视图
    var scrollView:UIScrollView?
    //食材首页的推荐视图
    private var recommendView:CBRecommendView?
    //首页食材推荐视图
    private var foodView:CBMaterialView?
    
    //首页分类视图
    private var categoryView:CBMaterialView?
    
    //导航的标题视图
    private var segCtrl:KTCSegmentCtrl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化视图
        createHomePageView()
        //导航
        createMyNav()
        //下载推荐的推荐
        downloadRecommentData()
        
        //下载食材数据
        downloadFoodData()
        
        //下载分类
        downloadCategoryData()
    }
    
    //下载分类的数据
    func downloadCategoryData() {
        
        //参数
        let params = ["methodName":"CategoryIndex"]
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .Category
        
        downloader.postWithUrl(kHostUrl, params: params)
        
        
    }

    
    //创建导航
    func createMyNav(){
        //标题位置
        segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kSreenWith-80*2, 44), titleNames: ["推荐","食材","分类"])
        //设置代理
        segCtrl?.delegate = self
        
        
        navigationItem.titleView = segCtrl
        
        
        
        //扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        //搜索
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
    }
    
    //扫一扫
    func scanAction(){}
    
    //搜索
    func searchAction(){}
    
    //初始化视图
    func createHomePageView(){
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        //创建一个滚动视图
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        //约束
        scrollView!.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            
            
        }
        
        
        //2.创建容器视图
        let containerView = UIView.createView()
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView!.bounces = false
        //设置代理
        scrollView?.delegate = self
        scrollView!.addSubview(containerView)
    
        //约束
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            
            make.edges.equalTo(self!.scrollView!)
            make.height.equalTo(self!.scrollView!)
        }
        
        //3添加子视图
        
        
        
        //3.1推荐
        recommendView = CBRecommendView()
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kSreenWith)
            make.left.equalTo(containerView)
            //make.edges.equalTo(containerView)
        })
        
        //3.2食材
        foodView = CBMaterialView()
        foodView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(foodView!)
        //约束
        foodView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kSreenWith)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        
        //3.3分类
        
        categoryView = CBMaterialView()
        categoryView?.backgroundColor = UIColor.grayColor()
        containerView.addSubview(categoryView!)
        //约束
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kSreenWith)
            make.left.equalTo((foodView?.snp_right)!)
        })

        
        //4.修改容器视图大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
        
        
    }
    
    
    //下载数据
    func downloadRecommentData(){
        //methodName=SceneHome&token=&user_id=&version=4.5
        
        let paramDict = ["methodName": "SceneHome"]
        let downloader = KTCDownloader()
        downloader.type = .Recommend
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: paramDict)
    }
    
    //下载食材数据
    func downloadFoodData(){
        /**
         methodName=MaterialSubtype&token=&user_id=&version=4.32
         */
        
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.type = .FoodMaterial
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
    
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoFoodCoursePage(link:String){
        let str:NSString = link
        let array:NSArray = str.componentsSeparatedByString("#")
        let id = array[1] as! String
        let foodCourseCtrl = FoodCourseViewController()
        foodCourseCtrl.serialId = id
        navigationController?.pushViewController(foodCourseCtrl, animated: true)
    }
    
    //显示首页推荐的数据
    func showRecommendData(model:CBRecommendModel){
        recommendView?.model = model
        
        //点击事件
        recommendView?.clickClosure = {
            [weak self]
            (title:String?,link:String) in
            if link.hasPrefix("app://food_course_series") == true{
                //食材课程分集显示
                
                
                self!.gotoFoodCoursePage(link)
            }
        }
    }
    
    
    
    
    

}
//MARK:KTCDownloader代理
extension CookbookViewController:KTCDownloaderDelegate{
    func downloder(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloder(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        
        if downloader.type == .Recommend{
            //推荐
            if let jsonData = data {
                let model = CBRecommendModel.parseModel(jsonData)
                //显示数据
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    //self!.recommendView?.model = model
                    
                    self!.showRecommendData(model)
                    })
            }
            
            
        
        }else if downloader.type == .FoodMaterial{
            //let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print(str!)
            if let jsonData = data{
                let model = CBMaterialModel.parseModelWithData(jsonData)
                //显示数据
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.foodView?.model = model
                    })
            }
            
            
        }else if downloader.type == .Category{
        
            if let jsonData = data{
                let model = CBMaterialModel.parseModelWithData(jsonData)
                //显示数据
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    self!.categoryView?.model = model
                    })
            }
        }
        
        
        
    }
}

//MARK:KTCSegmentCtrl代理
extension CookbookViewController:KTCSegmentCtrlDelegate{
    func didSelectSegCtrl(segCtrl: KTCSegmentCtrl, aIndex index: Int) {
        //scrollView?.contentOffset =
        scrollView?.setContentOffset(CGPointMake(kSreenWith*CGFloat(index), 0), animated: true)
    }
}
//MARK:UIScrollView代理
extension CookbookViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        segCtrl?.selectIndex = index
    }
}
