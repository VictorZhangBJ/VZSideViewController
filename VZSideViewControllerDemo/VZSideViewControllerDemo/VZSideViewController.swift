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
    
    var previoutPositionX: CGFloat = 0.0     //记录滑动手势上次所在X位置
    let LeftMaxCenterX: CGFloat = UIScreen.mainScreen().bounds.size.width * 7.0 / 6.0
    let maxScale: CGFloat = 0.75
    let offsetScale: CGFloat = 0.25
    let offsetX = UIScreen.mainScreen().bounds.size.width * 0.78
    
    var destinationCenterX = 0.0;
    
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
        let positionX = panGesture.locationInView(self.view).x
        let translationPointX = panGesture.translationInView(mainViewController!.view).x
        
        print("translationX = \(translationPointX)------- positionX = \(positionX)", appendNewline: true)
        
        let anchorPointX = panGesture.view!.center.x + translationPointX
        
        if anchorPointX <= LeftMaxCenterX && anchorPointX >= 0{
            panGesture.view!.center = CGPointMake(self.view.center.x + positionX, panGesture.view!.center.y)
            let scale = 1 - ((positionX / offsetX) * offsetScale)
            //panGesture.view?.transform = CGAffineTransformMakeScale(scale, scale)

        }else{
            print("已到截至位置", appendNewline: true)
            print("截至 centerX = \(panGesture.view?.center.x)", appendNewline: true)
            print("leftMaxCenterX = \(LeftMaxCenterX)", appendNewline: true)
        }
        
        //手势修正
        if panGesture.state == UIGestureRecognizerState.Ended {
            //显示主视图
            if panGesture.view?.center.x <= UIScreen.mainScreen().bounds.size.width {
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
            self.mainViewController?.view.transform = CGAffineTransformMakeScale(0.75, 0.75)
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
