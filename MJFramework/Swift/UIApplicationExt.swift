//
//  UIApplicationExt.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/7.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// 状态栏
    var statusBarUIView: UIView? {
        
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.first
            //
            let tag = 38482458
            if let statusBar = keyWindow!.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag
                keyWindow!.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
    
    /// 设置状态栏背景颜色
    func setStatusBarBackgroundColor(color: UIColor) {
        if statusBarUIView != nil {
            statusBarUIView!.backgroundColor = color
        }
    }
    
    /// 获取keyWindow
    static func getKeyWindow() -> UIWindow? {
        var keyWindow: UIWindow? = nil
        //
        if #available(iOS 13.0, *) {
            for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                if windowScene.activationState == .foregroundActive {
                    keyWindow = windowScene.windows.first
                    break
                }
            }
            return keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
}
