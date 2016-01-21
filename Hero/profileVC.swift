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
class profileVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    //property
    @IBOutlet weak var playerIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerLevel: UILabel!
    @IBOutlet weak var playerFC: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet var lastUserViews: [LastUseView]!
    
    @IBAction func moreHero(sender: UIButton) {
        print("More")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        requestPlayerRankClass()
        requestLastUsed()
//        let view = ViewController();
//        
//        view.block = asd;
//
//        self.presentViewController(view, animated: false , completion: nil);
        requestPlayerDetail();
    }
    //sd_setImageWithURL(NSURL(string: "http://www.szplanner.com/images/inside/product_activity_thumb.jpg"), placeholderImage: UIImage(named: "nopic.jpg"))
    
    @IBAction func searchOther(sender: UIBarButtonItem) {
        requestLastUsed()
//        let view = ViewController();
//        
//        view.block = asd;
//        
//        self.presentViewController(view, animated: true , completion: nil);
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
    
    func requestLastUsed(){
        let url = "http://www.yuelol.com/lastUsed?";
        let dic:[String:String] = ["playerName":"Windream","serverName":"弗雷尔卓德"];
        self.GET(url, parameters: dic, success: { (object) -> Void in
            
            let state = object?.objectForKey("status") as! NSNumber;
            if state.integerValue == 200 {
                let jsonArr:[AnyObject] = object?.objectForKey("lastused") as![AnyObject];
                let modelArr = try!MTLJSONAdapter.modelsOfClass(LastUsedList.self, fromJSONArray: jsonArr)
                
                for var i = 0; i<5; i++ {
                    let model = modelArr[i] as! LastUsedList;
                    self.lastUserViews[i].image.sd_setImageWithURL(NSURL(string: model.hero_icon!), placeholderImage: UIImage(named: "Image"));
                    self.lastUserViews[i].selectCount.text = model.choose_count.description + "场";
                    self.lastUserViews[i].winPer.text = model.hero_per;
                }
                
                print(modelArr.description);

            }
            
            
            }) { (error) -> Void in
                
        }
        
    }
    
    //mark tableViewDataSoucre
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return section == 0 ? 1:20;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    
        return 2;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell:UITableViewCell;
        if indexPath.section == 0{
            let reuseIdentifier = "AlwaysCell";
             cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)as!AlwaysCell;
        }else{
            let reuseIdentifier = "AlwaysCell";
             cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath);
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 90;
        
    }
}
