//
//  ViewController.swift
//  VZSideViewControllerDemo
//
//  Created by mini4s215 on 9/14/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkGrayColor()
        // Do any additional setup after loading the view, typically from a nib.
        
        let transferBtn = UIButton(type: UIButtonType.System)
        transferBtn.frame = CGRectMake(100, 300, 100, 30)
        transferBtn.setTitle("转换页面", forState: UIControlState.Normal)
        transferBtn.addTarget(self, action: "transferBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(transferBtn)
        
        let label = UILabel(frame: CGRectMake(120, 250, 100, 30))
        self.view.addSubview(label)
        label.text = "主视图";
        
        
    }
    
    func transferBtnClick() {
        print("点击转换按钮", appendNewline: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

