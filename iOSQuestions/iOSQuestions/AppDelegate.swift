//
//  AppDelegate.swift
//  iOSQuestions
//
//  Created by 郭明健 on 2021/3/31.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK:-

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 默认显示工作台
        jumpToWorkbench()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    //MARK:-

    /// 跳转到工作台
    func jumpToWorkbench() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let tabbarVC = BaseTabBarViewController.init()
        self.window?.rootViewController = tabbarVC
        self.window?.makeKeyAndVisible()
    }

    /// 配置键盘回缩
    func configIQKeyboardManager() {
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.enable = true
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.enableAutoToolbar = true
        keyboardManager.keyboardDistanceFromTextField = 30.0
        keyboardManager.toolbarDoneBarButtonItemText = "完成"
        keyboardManager.toolbarManageBehaviour = .byPosition
    }

}

