//
//  BaseCommon.swift
//  iOSQuestions
//
//  Created by 郭明健 on 2021/4/1.
//

import UIKit

//MARK:- 常量定义

/// 状态栏高度
public let kStatusBarH = UIApplication.shared.statusBarFrame.size.height
/// 导航栏Bar高度
public let kNavigationBarH = UINavigationController.init().navigationBar.frame.height
/// 导航高度
public let kNavigationH = (kStatusBarH + kNavigationBarH)
/// TabBar高度
public let kTabBarH = UITabBarController.init().tabBar.frame.height
/// 屏幕宽
public let kScreenW = UIScreen.main.bounds.size.width
/// 屏幕高
public let kScreenH = UIScreen.main.bounds.size.height
/// 底部安全间距
public let kBottomSafeAreaHeight: CGFloat = {
    var bottomSafeAreaHeight: CGFloat = 0.0
    if #available(iOS 11.0, *) {
        bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    }
    return bottomSafeAreaHeight
}()

/// isIphone
public let IPHONE_X: Bool = {
    if kBottomSafeAreaHeight > 0 {
        return true
    }
    return false
}()

/// 常用方法
class BaseCommon: NSObject {

    /// 单例
    static let shared: BaseCommon = {
        let shared = BaseCommon()
        return shared
    }()

    /// 获取keyWindow
    static func keyWindow() -> UIWindow? {

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

    //MARK:-

    /// Document 目录
    static func getDocumentPath() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documnetPath = documentPaths[0]
        return documnetPath
    }

    /// Library 目录
    static func getLibraryPath() -> String {
        let libraryPaths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        let libraryPath = libraryPaths[0]
        return libraryPath
    }

    /// Temp 目录
    static func getTempPath() -> String {
        let tempPath = NSTemporaryDirectory()
        return tempPath
    }

    /// Library/Caches目录
    static func getLibraryCachePath() -> String {
        let cachePaths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let cachePath = cachePaths[0]
        return cachePath
    }
}
