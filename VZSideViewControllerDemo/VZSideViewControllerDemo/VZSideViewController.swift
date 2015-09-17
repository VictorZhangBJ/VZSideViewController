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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
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
        let translationPointX = panGesture.translationInView(mainViewController?.view).x
        if panGesture.view?.center.x >= LeftMaxCenterX {
            print("view.centerX = \(panGesture.view?.center.x)", appendNewline: true)
            print("截至: \(translationPointX)", appendNewline: true)

            return
        }
        
        print("translationViweX: \(translationPointX)", appendNewline: true)
        
        
        
        
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
