//
//  CookbookViewController.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/15.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit

class CookbookViewController: BaseViewController {
    //食材首页的推荐视图
    private var recommendView:CBRecommendView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化视图
        createHomePageView()
        //导航
        createMyNav()
        self.downloadRecommentData()
    }
    
    
    
    //创建导航
    func createMyNav(){
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
        recommendView = CBRecommendView()
        view.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
        
    }
    
    
    //下载数据
    func downloadRecommentData(){
        //methodName=SceneHome&token=&user_id=&version=4.5
        
        let paramDict = ["methodName": "SceneHome","token":" ","version":"4.5"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: paramDict)
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
//MARK:KTCDownloader代理
extension CookbookViewController:KTCDownloaderDelegate{
    func downloder(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloder(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if let jsonData = data {
            let model = CBRecommendModel.parseModel(jsonData)
            //显示数据
            dispatch_async(dispatch_get_main_queue(), { 
                [weak self] in
                self!.recommendView?.model = model
            })
        }
        
    }
}
