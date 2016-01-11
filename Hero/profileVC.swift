//
//  profileVC.swift
//  Hero
//
//  Created by lei_dream on 16/1/8.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

import UIKit
import Mantle
import SDWebImage
class profileVC: UIViewController {

    //property
    @IBOutlet weak var playerIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerLevel: UILabel!
    @IBOutlet weak var playerFC: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad();
        
        requestPlayerRankClass()
//        let view = ViewController();
//        
//        view.block = asd;
//
//        self.presentViewController(view, animated: false , completion: nil);
        requestPlayerDetail();
    }
    //sd_setImageWithURL(NSURL(string: "http://www.szplanner.com/images/inside/product_activity_thumb.jpg"), placeholderImage: UIImage(named: "nopic.jpg"))
    
    @IBAction func searchOther(sender: UIBarButtonItem) {
        let view = ViewController();
        
        view.block = asd;
        
        self.presentViewController(view, animated: true , completion: nil);
    }
    
    func asd(playerDetailModel:PlayerDetail) -> Void{
        self.nameLabel.text  = playerDetailModel.playerName! + "(" + playerDetailModel.serverName! + ")"
        self.playerLevel.text = "等 级：" + playerDetailModel.playerLevel!;
        self.playerFC.text = "战斗力：" + playerDetailModel.playerFC!;
        self.playerIcon.sd_setImageWithURL(NSURL(string: playerDetailModel.playerIcon!), placeholderImage: UIImage(named: "Image"));
    }

    func requestPlayerDetail(){
        //
        RequestManager.sharedInstance().requestGet("playerDetail", serverName: "弗雷尔卓德", playerName: "Windream", className: "PlayerDetail", success: { (object) -> Void in
            
            let playerDetailModel = object as!PlayerDetail;
            if(playerDetailModel.status.integerValue == 200){
                
                self.nameLabel.text  = "Windream(弗雷尔卓德)";
                self.playerLevel.text = "等 级：" + playerDetailModel.playerLevel!;
                self.playerFC.text = "战斗力：" + playerDetailModel.playerFC!;
                self.playerIcon.sd_setImageWithURL(NSURL(string: playerDetailModel.playerIcon!), placeholderImage: UIImage(named: "Image"));
            }else{
                self.view.makeDefaultToast(playerDetailModel.message!);
            }
            
            }) { (error) -> Void in
                self.view.makeDefaultToast("网络异常,请检查网络")
        }
    }
    
    func requestPlayerRankClass(){
        
        //
        RequestManager.sharedInstance().requestGet("playerRankClass", serverName: "弗雷尔卓德", playerName: "Windream", className: "PlayerRankClass", success: { (object) -> Void in
            
            let model = object as!PlayerRankClass;
            if(model.status.integerValue == 200){
                
                if model.rankClass!.characters.count <= 0{
                }else{
                    self.playerLevel.text = self.playerLevel.text! + "   排位等级：" + model.rankClass!;
                }

            }else{
                self.view.makeDefaultToast("数据出现错误");
            }
            
            }) { (error) -> Void in
                self.view.makeDefaultToast("网络异常,请检查网络")
        }
        
    }
}
