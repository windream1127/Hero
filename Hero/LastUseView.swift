//
//  LastUseView.swift
//  Hero
//
//  Created by lei_dream on 16/1/18.
//  Copyright © 2016年 lei_dream. All rights reserved.
//

import UIKit

class LastUseView: UIView {
    
    var image: UIImageView = UIImageView();
    var selectCount: UILabel = UILabel()
    var winPer: UILabel = UILabel()
    
    //初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.backgroundColor = UIColor.greenColor();
        self.image = UIImageView(image: UIImage(named: "Image"));
        addSubview(self.image);
        
        self.selectCount = UILabel();
        self.selectCount.font = UIFont.systemFontOfSize(10);
        self.selectCount.textAlignment = .Center;
        self.selectCount.backgroundColor = UIColor.yellowColor();
        
        self.winPer = UILabel();
        self.winPer.font = UIFont.systemFontOfSize(10);
        self.winPer.textAlignment = .Center;
        self.winPer.backgroundColor = UIColor.yellowColor();
        
        addSubview(self.selectCount);
        addSubview(self.winPer);
    }
    
    //自动布局
    override func intrinsicContentSize()->CGSize{
        let buttonWidth = Int(frame.size.width);
        return CGSize(width: buttonWidth, height: buttonWidth*2);
    }
    
    override func layoutSubviews() {
        let spacing = 8;
        let buttonSize = Int(frame.size.width);
        let labelHeight = (buttonSize-3*spacing)/2
        
        let imageFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize);
        self.image.frame = imageFrame;
        
        self.selectCount.frame = CGRect(x: 0, y: buttonSize + spacing, width: buttonSize, height: labelHeight);
        self.winPer.frame = CGRect(x: 0, y: buttonSize + spacing*2 + labelHeight, width: buttonSize, height: labelHeight);
    }
}
