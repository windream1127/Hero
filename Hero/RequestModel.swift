//
//  RequestModel.swift
//  Hero
//
//  Created by lei_dream on 16/1/7.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

import UIKit
import Mantle

@objc(PlayerDetail)class PlayerDetail:MTLModel, MTLJSONSerializing{
    //成员变量
    /*
    方法参数:

    {serverName} : 大区中文名称
    {playerName} : 玩家名称
    方法返回:

    status : 操作返回值
    playerIcon : 玩家头像
    playerLevel : 玩家等级
    playerFC : 玩家战斗力(多玩)
    */
    var playerLevel:String?;
    var status:NSNumber!;
    var playerIcon:String?;
    var playerFC:String?;
    var message:String?;
    var playerName:String?;
    var serverName:String?;

    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]!
    {
        return ["playerLevel" : "playerLevel",
                "status" : "status",
                "playerIcon" : "playerIcon",
                "playerFC" : "playerFC",
                "message" : "message",]
    }
}

@objc(PlayerRankClass)class PlayerRankClass:MTLModel, MTLJSONSerializing{
    
    var rankClass:String?;
    var status:NSNumber!;

    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]!
    {
        return ["rankClass" : "rankClass",
                "status" : "status",]
    }
}

@objc(LastUsed)class LastUsed:MTLModel, MTLJSONSerializing{
    
    var userList:[LastUsedList]?;
    var status:NSNumber!;
    
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]!
    {
        return ["userList" : "userList",
            "status" : "status",]
    }
    
    static func userListJSONTransfrmer(){
        
    }
}

class LastUsedList:MTLModel, MTLJSONSerializing{
    var hero_name:String!;
    var choose_count:NSNumber!;
    var hero_icon:String!;
    var hero_per:String!;
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]!
    {
        return ["hero_name" : "hero_name",
            "choose_count" : "choose_count",
        "hero_icon" : "hero_icon",
        "hero_per" : "hero_per",]
    }
}










