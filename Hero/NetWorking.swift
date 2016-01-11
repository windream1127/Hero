//
//  NetWorking.swift
//  Hero
//
//  Created by lei_dream on 16/1/6.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import Toast

extension NSObject {
    
    func GET(URLString:String, parameters:[String:AnyObject]?, showHUD:Bool = true, success:((AnyObject?) -> Void)?, failure:((NSError) -> Void)? ){
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        let keyWindow = UIApplication.sharedApplication().delegate!.window!
        if showHUD {
            MBProgressHUD.showHUDAddedTo(keyWindow, animated: true)
        }
        manager.GET(URLString, parameters: parameters, success: { (operation, responseObject) -> Void in
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(keyWindow, animated: true)
            }
            
            success?(responseObject)
            }, failure: { (aFHTTPRequestOperation, error) -> Void in
                if showHUD {
                    MBProgressHUD.hideAllHUDsForView(keyWindow, animated: true)
                    keyWindow?.makeDefaultToast("网络异常,请检查网络")
                }
                failure?(error)
        })
    }
    
    func POST(URLString:String, parameters:[String:AnyObject]?, showHUD:Bool = true, success:((AnyObject?) -> Void)?, failure:((NSError) -> Void)?){
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        let keyWindow = UIApplication.sharedApplication().keyWindow
        if showHUD {
            MBProgressHUD.showHUDAddedTo(keyWindow, animated: true)
        }
        manager.POST(URLString, parameters: parameters, success: { (operation, responseObject) -> Void in
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(keyWindow, animated: true)
            }
            success?(responseObject)
            }, failure: { (aFHTTPRequestOperation, error) -> Void in
                if showHUD {
                    MBProgressHUD.hideAllHUDsForView(keyWindow, animated: true)
                    keyWindow?.makeDefaultToast("网络异常,请检查网络")
                }
                failure?(error)
        })
    }
    
}

extension UIView {
    func makeDefaultToast(message:String) {
        makeToast(message, duration: 2, position: CSToastPositionCenter)
    }
}
