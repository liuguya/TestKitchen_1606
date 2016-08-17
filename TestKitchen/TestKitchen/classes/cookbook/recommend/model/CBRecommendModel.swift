//
//  CBRecommendModel.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/16.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit
import SwiftyJSON

class CBRecommendModel: NSObject {
    
    var code:NSNumber?
    var msg:Bool?
    var version:String?
    var timestamp:NSNumber?
    var data:CBRecommendDataModel?
    
    //解析
    class func parseModel(data:NSData)->CBRecommendModel{
        let model = CBRecommendModel()
        let jsonData = JSON(data:data)
        model.code = jsonData["code"].number
        model.msg = jsonData["msg"].bool
        model.version = jsonData["version"].string
        model.timestamp = jsonData["timestamp"].number
        
        let dataDict = jsonData["data"]
        model.data = CBRecommendDataModel.parseModel(dataDict)
        
        return model
    }
}

class CBRecommendDataModel:NSObject{
    var banner:Array<CBRecommendBannerModel>?
    var widgetList:Array<CBRecommendWidgetListModel>?
    
    class func parseModel(jsonData:JSON)->CBRecommendDataModel{
        let model = CBRecommendDataModel()
        let bannerArray = jsonData["banner"]
        var bArray = Array<CBRecommendBannerModel>()
        for (_,subjson) in bannerArray{
            //subjson装换成CBRecommendBannerModel
            let bannerModel = CBRecommendBannerModel.parseModel(subjson)
            bArray.append(bannerModel)
            
        }
        model.banner = bArray
        
        let listArray = jsonData["widgetList"]
        var wlArray = Array<CBRecommendWidgetListModel>()
        for (_,subjson) in listArray{
            let widModel = CBRecommendWidgetListModel.parseModel(subjson)
            wlArray.append(widModel)
        }
        model.widgetList = wlArray
        
        
       return model
    }
}


class CBRecommendBannerModel: NSObject {
    var banner_id:NSNumber?
    var banner_title:String?
    var banner_picture:String?
    var banner_link:String?
    var is_link:NSNumber?
    var refer_key:String?
    var type_id:NSNumber?
    
    class func parseModel(jsonData:JSON)->CBRecommendBannerModel{
        let model = CBRecommendBannerModel()
        model.banner_id = jsonData["banner_id"].number
        model.banner_title = jsonData["banner_title"].string
        model.banner_picture = jsonData["banner_picture"].string
        model.banner_link = jsonData["banner_link"].string
        model.is_link = jsonData["is_link"].number
        model.refer_key = jsonData["refer_key"].string
        model.type_id = jsonData["type_id"].number
        
        return model
    }
}

class CBRecommendWidgetListModel:NSObject{
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    var title:String?
    var title_link:String?
    var desc:String?
    var widget_data:Array<CGRecommendWidgetDataModel>?
    
    class func parseModel(jsonData:JSON)->CBRecommendWidgetListModel{
        let model = CBRecommendWidgetListModel()
        model.widget_id = jsonData["widget_id"].number
        model.widget_type = jsonData["widget_type"].number
        model.title = jsonData["title"].string
        model.title_link = jsonData["title_link"].string
        model.desc = jsonData["desc"].string
        
        let dataArray = jsonData["widget_data"]
        var wdArray = Array<CGRecommendWidgetDataModel>()
        for (_,subjson) in dataArray{
            let  widgetModel = CGRecommendWidgetDataModel.parseModel(subjson)
            wdArray.append(widgetModel)
            
        }
        model.widget_data = wdArray
        
        
        return model
    }
    
}

class CGRecommendWidgetDataModel: NSObject {
    var id:NSNumber?
    var type:String?
    var content:String?
    var link:String?
    
    class func parseModel(jsonData:JSON)->CGRecommendWidgetDataModel{
        let modle = CGRecommendWidgetDataModel()
        modle.id = jsonData["id"].number
        modle.type = jsonData["type"].string
        modle.content = jsonData["content"].string
        modle.link = jsonData["link"].string
        return modle
    }
}


