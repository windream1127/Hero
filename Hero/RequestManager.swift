//
//  RequestManager.swift
//  Hero
//
//  Created by lei_dream on 16/1/7.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

import UIKit
import Mantle

/* 接口列表
playerDetail：玩家信息查询
playerRecord：玩家战绩统计
lastUsed    : 最近常用英雄
heroRecord  ：英雄是用数据
playerRankClass：玩家段位

*/
class RequestManager:NSObject{
    let baseUrlString:String = "http://www.yuelol.com/";
    
    override init(){
        super.init();
    }
    
    class func sharedInstance()->RequestManager{
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : RequestManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = RequestManager()
        }
        return Static.instance!
    }
    
    func requestGet(massageName:String?,serverName:String,playerName:String,className:String,success:((AnyObject?) -> Void)?,failure:((NSError) -> Void)?){
        
        if massageName == nil{
            print("未填写massageName！");
            return;
        }
        let url = baseUrlString + massageName! + "?";
        
        let modelClass:AnyClass? = NSClassFromString(className);
        
        let dic:[String:String] = ["serverName":serverName,"playerName":playerName];
        self.GET(url, parameters: dic , success: { (object) -> Void in
            let model :AnyObject;

            model = try!MTLJSONAdapter.modelOfClass(modelClass.self, fromJSONDictionary: object as![NSObject:AnyObject])
            success?(model);

            }) { (error ) -> Void in
                failure?(error);
        };
    }
}