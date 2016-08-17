//
//  KTCDownloader.swift
//  TestKitchen
//
//  Created by 阳阳 on 16/8/16.
//  Copyright © 2016年 liuguyang. All rights reserved.
//

import UIKit
import Alamofire
protocol KTCDownloaderDelegate:NSObjectProtocol{
    func downloder(downloader:KTCDownloader , didFailWithError error:NSError)
    func downloder(downloader:KTCDownloader , didFinishWithData data:NSData?)
}

public enum KTCDownloaderType: Int {
  case Default = 10
    
}
class KTCDownloader: NSObject {
   
    weak var delegate:KTCDownloaderDelegate?
    //类型
    var type:KTCDownloaderType = .Default
    func postWithUrl(urlString:String,params:Dictionary<String,String>?){
        Alamofire.request(.POST, urlString, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            switch response.result{
            case .Failure(let error):
                self.delegate?.downloder(self, didFailWithError: error)
            case .Success:
                self.delegate?.downloder(self, didFinishWithData: response.data!)
            }
        }
    }
}
