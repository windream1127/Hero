//
//  ViewController.swift
//  Hero
//
//  Created by lei_dream on 15/12/30.
//  Copyright © 2015年 lei_dream. All rights reserved.
//

import UIKit
import Mantle
class ViewController: UIViewController,UITextFieldDelegate,WDMPickerViewDelegate {

    //property
    var nameTextField: UITextField!
    var FWQBT: UIButton!
    var BDBT: UIButton!
    var viewasd:WDMPIckView!
    var FWQList:[String]?
    var block:((object:PlayerDetail) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSThread.sleepForTimeInterval(1.5);
        
        self.buildFrame();
    }
    func loadGameData() {
        var listData: NSArray = NSArray()
        
        let filePath = NSBundle.mainBundle().pathForResource("serverNameList.plist", ofType:nil )
        listData = NSArray(contentsOfFile: filePath!)!
        FWQList = listData as? [String];
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    
    
    func buildFrame(){
        let filePath = NSBundle.mainBundle().pathForResource("railway", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        
        let webViewBG = UIWebView(frame: self.view.frame)
        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webViewBG.userInteractionEnabled = false;
        self.view.addSubview(webViewBG)
        
        let filter = UIView()
        filter.frame = self.view.frame
        filter.backgroundColor = UIColor.blackColor()
        filter.alpha = 0.05
        self.view.addSubview(filter)
        
        let welcomeLabel = UILabel(frame: CGRectMake(0, 100, self.view.bounds.size.width, 100))
        welcomeLabel.text = "请绑定账号"
        welcomeLabel.textColor = UIColor.whiteColor()
        welcomeLabel.font = UIFont.systemFontOfSize(50)
        welcomeLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(welcomeLabel)
        
        //name
        let textfiled = UITextField(frame:CGRectMake((self.view.bounds.size.width-240)/2, 300, 240, 40));
        textfiled.layer.borderColor = UIColor.whiteColor().CGColor;
        textfiled.layer.borderWidth = 2
        textfiled.textColor = UIColor.whiteColor();
        let placeHolder = NSAttributedString(string: "请输入昵称", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()]);
        //        textfiled.placeholder = "请输入昵称";
        textfiled.attributedPlaceholder = placeHolder;
        textfiled.textAlignment = .Center;
        textfiled.tag = 100001;
        textfiled.delegate = self;
        nameTextField = textfiled;
        self.view.addSubview(textfiled)
        
        //fwq
        let loginBtn = UIButton(frame: CGRectMake((self.view.bounds.size.width-240)/2, 360, 240, 40))
        loginBtn.layer.borderColor = UIColor.whiteColor().CGColor
        loginBtn.layer.borderWidth = 2
        loginBtn.titleLabel!.font = UIFont.systemFontOfSize(24)
        loginBtn.tintColor = UIColor.whiteColor()
        loginBtn.setTitle("请选择服务器", forState: UIControlState.Normal)
        loginBtn.addTarget(self, action: "selectServer", forControlEvents: .TouchUpInside);
        FWQBT = loginBtn;
        self.view.addSubview(loginBtn)
        
        //bd
        let signUpBtn = UIButton(frame: CGRectMake((self.view.bounds.size.width-240)/2, 420, 240, 40))
        signUpBtn.layer.borderColor = UIColor.whiteColor().CGColor
        signUpBtn.layer.borderWidth = 2
        signUpBtn.titleLabel!.font = UIFont.systemFontOfSize(24)
        signUpBtn.tintColor = UIColor.whiteColor()
        signUpBtn.setTitle("绑定", forState: UIControlState.Normal)
        signUpBtn.addTarget(self, action: "bangding", forControlEvents: .TouchUpInside);
        BDBT = signUpBtn;
        self.view.addSubview(signUpBtn)
        
        
        //tap
        let tapGst = UITapGestureRecognizer(target: self, action: "registerEditing");
        self.view .addGestureRecognizer(tapGst);
    }
    
    func selectServer(){
        
        registerEditing();
        loadGameData()
        let view = WDMPIckView(list: self.FWQList!);
        view.delegate = self;
        view.title = self.FWQBT.titleLabel?.text;
        view.show();
    }
    
    func bangding(){
        registerEditing();
        RequestManager.sharedInstance().requestGet("playerDetail", serverName: (self.FWQBT.titleLabel?.text)!, playerName: self.nameTextField.text!, className: "PlayerDetail", success: { (object) -> Void in
            
            let playerDetailModel = object as!PlayerDetail;
            if(playerDetailModel.status.integerValue == 200){
                
                playerDetailModel.playerName = self.nameTextField.text!;
                playerDetailModel.serverName = (self.FWQBT.titleLabel?.text)!;
                self.block?(object: playerDetailModel);
                dispatch_after(1, dispatch_get_main_queue(), { () -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil);
                })

            }else{
                self.view.makeDefaultToast(playerDetailModel.message!);
            }
            
            }) { (error) -> Void in
                self.view.makeDefaultToast("网络异常,请检查网络")
        }
    }
    

    
    func registerEditing(){
        self.view.endEditing(true );
    }
    
    
    //ttextfiledDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        self.view.endEditing(true );
        return true;
    }
    
    func WDMPickerViewClickFinish(pickerView: WDMPIckView, title:String, row:Int){
        self.FWQBT.setTitle(title, forState: .Normal);
    }
}

