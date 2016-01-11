//
//  WDMPIckView.swift
//  Hero
//
//  Created by lei_dream on 16/1/4.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

import UIKit



@objc public protocol WDMPickerViewDelegate {
    optional func WDMPickerView(pickerView: WDMPIckView, datalist:[String])
    optional func WDMPickerViewClickFinish(pickerView: WDMPIckView, title:String, row:Int)
    optional func WDMPickerViewClickDismiss(pickerView: WDMPIckView)
}



public class WDMPIckView: UIView,UIPickerViewDelegate ,UIPickerViewDataSource{

    //property
    var cancelBt :UIButton!   ///取消按钮
    var confirmBt:UIButton!   ///确定按钮
    var listView:UIPickerView! ///列表视图
    var backView:UIView!;
    var listData    :NSArray! = nil{
        didSet{
            listView.reloadAllComponents();
        }
    }///数据列表
    
    var title :String! = nil{
        didSet{
            if let str = title{
                if listData.containsObject(str) {
                    let row = listData.indexOfObject(str);
                    listView.selectRow(row, inComponent: 0, animated:false);
                }
            }
        }
    }
    weak var delegate:WDMPickerViewDelegate? = nil;
    
    private func initialize() {
        let screenFrame = UIScreen.mainScreen().bounds;
        let backViewHeight:CGFloat = 250;
        let pickViewHeight:CGFloat = 180;
        let buttonWidth:CGFloat = 67;
        let buttonHeight:CGFloat = 40;
        let gap:CGFloat = 15;

        //topView
        let topView = UIView(frame: screenFrame)
        topView.backgroundColor = UIColor.blackColor();
        topView.alpha = 0.5;
        self.addSubview(topView);
        
        //backView
        backView = UIView(frame: CGRect(x: 0, y: screenFrame.size.height, width: screenFrame.size.width, height: backViewHeight));
        backView.backgroundColor = UIColor.whiteColor();
        self.addSubview(backView);
        //button
        cancelBt = UIButton(type: .System);
        cancelBt.setTitle("取消", forState: .Normal);
        cancelBt.setTitleColor(UIColor.blackColor(), forState: .Normal);
        cancelBt.addTarget(self, action: "dissmissBtnPress", forControlEvents: .TouchUpInside);
        cancelBt.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight);
        backView.addSubview(cancelBt);
        
        confirmBt = UIButton(type: .System);
        confirmBt.setTitle("确定", forState: .Normal);
        confirmBt.setTitleColor(UIColor.blackColor(), forState: .Normal);
        confirmBt.addTarget(self, action: "finishBtnPress", forControlEvents: .TouchUpInside);
        confirmBt.frame = CGRect(x: screenFrame.size.width - buttonWidth, y: 0, width: buttonWidth, height: buttonHeight);
        backView.addSubview(confirmBt);
        
        //pickerView
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: buttonHeight + gap, width: screenFrame.size.width, height: pickViewHeight+20));
        pickerView.delegate = self;
        pickerView.dataSource = self;
        self.listView = pickerView;
        backView.addSubview(pickerView);
    }
    
    public init(list:[String]){
        super.init(frame: UIScreen.mainScreen().bounds)
        self.listData = list;
        self.initialize()
    }
    
    public init() {
        super.init(frame: CGRectZero)
        self.initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }

    // MARK: Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    func finishBtnPress(){
        // something
        let row = listView.selectedRowInComponent(0);
        self.delegate?.WDMPickerViewClickFinish?(self, title: listData[row] as! String, row: row);
        hide();
        
    }
    
    func dissmissBtnPress(){
        // something
        self.delegate?.WDMPickerViewClickDismiss?(self);
        hide();
    }
    
    func show(){
        
        let win = UIApplication.sharedApplication().keyWindow;
        let topView = win?.subviews.first;
        topView?.addSubview(self);
        
        UIView.animateWithDuration(0.3) { () -> Void in
            let size = self.backView.frame.size;
            let frame = self.backView.frame;
            self.backView.frame = CGRect(x: 0, y: frame.origin.y - size.height, width: size.width, height: size.height);
        }
        
    }
    
    func hide(){
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alpha = 0;
            let size = self.backView.frame.size;
            let frame = self.backView.frame;
            self.backView.frame = CGRect(x: 0, y: frame.origin.y + size.height, width: size.width, height: size.height);
            }) { (Bool) -> Void in
                self.removeFromSuperview();
        }
    }

    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return listData?[row] as? String;
    }
    
    public func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 44.0;
    }
    
    // UIPickerViewDataSource
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1;
        
    }

    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return (listData?.count)!;
    }
}
