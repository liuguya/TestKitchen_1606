//
//  FoodCourseViewController.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/25.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class FoodCourseViewController: BaseViewController {
    var serialId:String?
    var serialIsExpand:Bool = false
    //当前选择的集数
    private var serialIndex:Int? = 0
    private var tbView:UITableView?
    
    private var serialModel:FoodCourseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMyNav()
        //print(serialId)
        //创建表格
        createTableView()
        
        //下载食客数据
        downloadFoodCourseData()
    }
    
    
    //下载食客数据
    func downloadFoodCourseData(){
        //methodName=CourseSeriesView&series_id=22&token=&user_id=&version=4.5
        if serialId == nil{
            return
        }
        var dict = Dictionary<String,String>()
        dict["methodName"] = "CourseSeriesView"
        dict["series_id"] = serialId
        
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .FoodCourse
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    
    func createMyNav(){
        //导航
        addNavBackBtn()
    }
    
    func createTableView(){
        tbView = UITableView(frame: CGRectMake(0, 0, kSreenWith, kSreenHeight), style: .Plain)
        tbView?.delegate = self
        tbView?.separatorStyle = .None
        tbView?.dataSource = self
        view.addSubview(tbView!)
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
extension FoodCourseViewController:KTCDownloaderDelegate{
    func downloder(downloader: KTCDownloader, didFailWithError error: NSError) {
        print("error")
    }
    
    func downloder(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if downloader.type == .FoodCourse{
            
            //let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            if let jsonData = data{
               let model = FoodCourseModel.parseModelWithData(jsonData)
                
                //回到住线程刷新UI
                dispatch_async(dispatch_get_main_queue(), { 
                    self.serialModel = model
                    self.tbView?.reloadData()
                })
                
            }
    
            
            
            
        }else if downloader.type == .FoodCourseComment{
        
        }
    }
}

extension FoodCourseViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0{
           //食材数据
            
         if serialModel?.data?.data?.count > 0{
                    rowNum = 3
         }
                
            
        }else if section == 1{
        
        }
        
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{

            if indexPath.row == 0{
                //视频cell
                height = 160
            }
            else if indexPath.row == 1{
                let model = serialModel?.data?.data![serialIndex!]
                if serialModel?.data?.data?.count > 0{
                    height = FCCourseCell.heightWithModel(model!)
                }
                
            }
            else if indexPath.row == 2{
                let cnt = serialModel?.data?.data!.count
                height = FCSerialCell.heightWithNum(cnt!, isExpand: serialIsExpand)
                
            }
        }else if indexPath.section == 1{
            
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0{
            //食材课程数据
            if indexPath.row == 0{
                //视频cell
             
                let videoModel = serialModel?.data?.data![serialIndex!]
                if serialModel?.data?.data?.count > 0{
                    cell = createVieoCellForTableView(tableView, atIndexPath: indexPath, withModel: videoModel!)
                }
                
               
            }
            else if indexPath.row == 1{
                let videoModel = serialModel?.data?.data![serialIndex!]
                if serialModel?.data?.data?.count > 0{
                cell = createCourseCellForTableView(tableView, atIndexPath: indexPath, withModel: videoModel!)
                }
            }
            else if indexPath.row == 2{
                cell = createSeaialCell(tableView, atIndexPath: indexPath, withModel: serialModel!)
            }
        }else if indexPath.section == 1{
            //评论
        }
        
        //取消选中状态
        cell.selectionStyle = .None
        
        return cell
 
    }
    
    
    func createVieoCellForTableView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel) -> UITableViewCell{
        //视频cell
        let cellId = "videoCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCVideoCell
        if nil == cell{
            cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
            
        }
        
    
        cell?.model = model
        cell?.videoClosure = {
            urlString in
            
            let url = NSURL(string: urlString)
            let play = AVPlayer(URL: url!)
            let playerCtrl = AVPlayerViewController()
            playerCtrl.player = play
            play.play()
            self.presentViewController(playerCtrl, animated: true, completion: nil)
            
        }
        return cell!
    }
    
    func createCourseCellForTableView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel) -> UITableViewCell{
        //视频cell
        let cellId = "courseCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCCourseCell
        if nil == cell{
            cell = NSBundle.mainBundle().loadNibNamed("FCCourseCell", owner: nil, options: nil).last as? FCCourseCell
            
        }
        
        
        cell?.model = model
        return cell!
    }
    
    func createSeaialCell(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseModel) -> UITableViewCell{
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSerialCell
        if cell == nil{
            cell = FCSerialCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.delegate = self
        cell?.isExpand = self.serialIsExpand
        cell?.num = model.data?.data?.count
        cell?.selectIndex = serialIndex!
        
        //cell?.backgroundColor = UIColor.blueColor()
        return cell!
        
    }
}

extension FoodCourseViewController:FCSerialCellDelegate{
    func didSelectSerialAtIndex(index: Int) {
        serialIndex = index
        
        tbView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    func changeExpandState(isExpand: Bool) {
        serialIsExpand = isExpand
        
        tbView?.reloadSections(NSIndexSet(index: 2), withRowAnimation: .Automatic)
    }
}


