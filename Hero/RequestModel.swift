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