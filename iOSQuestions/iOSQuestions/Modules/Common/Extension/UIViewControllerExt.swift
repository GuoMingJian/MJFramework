//
//  UIViewControllerExt.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/18.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK:- 获取当前控制器
    static func topMostController() -> UIViewController {
        var keyWindow: UIWindow? = nil
        //
        if #available(iOS 13.0, *) {
            for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
                if windowScene.activationState == .foregroundActive {
                    keyWindow = windowScene.windows.first
                    break
                }
            }
        } else {
            keyWindow = UIApplication.shared.keyWindow
        }
        //
        if keyWindow != nil {
            //
            var topVC = keyWindow!.rootViewController
            while ((topVC?.presentingViewController) != nil) {
                topVC = topVC?.presentingViewController
            }
            return topVC!
        } else {
            let vc = UIView.findCurrentViewController()
            return vc
        }
    }
    
}
