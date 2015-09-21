//
//  VZSideViewController.swift
//  VZSideViewControllerDemo
//
//  Created by mini4s215 on 9/14/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

import UIKit

class VZSideViewController: UIViewController,UIGestureRecognizerDelegate {

    var leftViewController: UIViewController?
    var mainViewController: UIViewController?
    var prevX: CGFloat = 0;
    var scale:CGFloat = 1.0;
    let LeftMaxCenterX: CGFloat = UIScreen.mainScreen().bounds.size.width * 7.0 / 6.0
    let maxScale: CGFloat = 0.75
    let offsetX = UIScreen.mainScreen().bounds.size.width * 0.78
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview((mainViewController?.view)!)
        self.view.addSubview((leftViewController?.view)!)
        leftViewController?.view.hidden = true
        mainViewController?.view.hidden = false
        
        //添加滑动手势
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        mainViewController?.view.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
        //添加单击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        mainViewController?.view.addGestureRecognizer(tapGesture);
        tapGesture.delegate = self;
        
    }
    
    func handleTap(tapGesture: UITapGestureRecognizer) {
        print("单击，showMainView")
        self.showMainView()
    }
    
    //手势代理方法
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let pointX = gestureRecognizer.locationInView(mainViewController!.view).x
        if pointX >= 100 {
            print("禁止滑动", appendNewline: true)
            return false
        }else {
            print("可以滑动", appendNewline: true)
            return true
        }
    }
    
    //处理滑动事件
    func handlePan(panGesture: UIPanGestureRecognizer){
        let translationPointX = panGesture.translationInView(mainViewController!.view).x
        let stepSpace = translationPointX - prevX
        
        let anchorPointX = self.mainViewController!.view!.center.x + stepSpace
        
        if anchorPointX <= LeftMaxCenterX && anchorPointX >= self.view.center.x{
            self.mainViewController!.view!.center = CGPointMake(self.mainViewController!.view!.center.x + (translationPointX - prevX), self.mainViewController!.view!.center.y)
            
            scale = scale - (stepSpace / offsetX) * (1 - maxScale + 0.04);
            panGesture.view?.transform = CGAffineTransformMakeScale(scale, scale)
            prevX = translationPointX

        }else{
        
        }
        
        //手势修正
        if panGesture.state == UIGestureRecognizerState.Ended {
            prevX = 0
            //显示主视图
            if self.mainViewController!.view?.center.x <= UIScreen.mainScreen().bounds.size.width * 6.0 / 7.0{
                self.showMainView()
                
            }else{
                //显示左侧视图
                self.showLeftView()
            }
        }
      
    }
    
    func showMainView(){
        print("显示主视图修正", appendNewline: true)
        let interval: NSTimeInterval = 0.2
        UIView.animateWithDuration(interval, animations: { () -> Void in
            self.mainViewController?.view.center = CGPointMake(self.view.center.x, self.view.center.y)
            self.mainViewController?.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.scale = 1.0
            }, completion: { (finished: Bool) -> Void in
                print("修正结束", appendNewline: true)
        })
        
    }
    
    func showLeftView()
    {
        print("显示左视图修正", appendNewline: true)
        let interval: NSTimeInterval = 0.2
        UIView.animateWithDuration(interval, animations: { () -> Void in
            self.mainViewController?.view.center = CGPointMake(self.LeftMaxCenterX, self.view.bounds.size.height / 2.0)
            self.mainViewController?.view.transform = CGAffineTransformMakeScale(self.maxScale, self.maxScale)
            self.scale = self.maxScale;
            }, completion: { (finished: Bool) -> Void in
                print("修正结束", appendNewline: true)
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
