//
//  UIViewExt.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/9/10.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit
import AVFoundation

extension UIView {

    /// Xib初始化
    func initFromNib() -> UIView {
        let str : String = NSStringFromClass(self.classForCoder)
        if let classStr: String = (str as NSString).components(separatedBy: ".").last {
            return UINib.init(nibName: classStr, bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
        } else {
            return self
        }
    }

    /// 获取所有子View
    func getAllSubViews(rootView: UIView) -> Array<UIView> {
        var viewList: Array<UIView> = Array.init()
        for view in rootView.subviews {
            if view.subviews.count > 0 {
                viewList.append(contentsOf: getAllSubViews(rootView: view))
            } else {
                viewList.append(view)
            }
        }
        return viewList
    }

    //MARK:- 沙盒目录
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

    //MARK:- 未读消息（小红点）
    func showRedDot() {
        showRedDot(dotColor: UIColor.red, dotWidth: 10)
    }

    func showRedDot(dotColor: UIColor, dotWidth: CGFloat) {
        self.layoutIfNeeded()
        //
        let offset: CGFloat = 1
        let dotView = UIView.init()
        dotView.setCornerRadius(dotWidth/2.0)
        dotView.backgroundColor = dotColor
        dotView.tag = 1991
        self.addSubview(dotView)
        //
        let superWidth = self.frame.size.width
        let x: CGFloat = superWidth - (dotWidth/2+offset)
        let y: CGFloat = -(dotWidth/2-offset)
        let rect: CGRect = CGRect.init(x: x, y: y, width: dotWidth, height: dotWidth)
        dotView.frame = rect
    }

    func hiddenRedDot() {
        let dotView = self.viewWithTag(1991)
        if dotView != nil {
            dotView!.removeFromSuperview()
        }
    }
    //MARK:-
    func showUnreadMsgCount(unreadCount: Int) {
        var dotW: CGFloat = 15
        if unreadCount > 9 {
            dotW += 4
        }
        if unreadCount >= 99 {
            dotW += 5
        }
        showUnreadMsgCount(unreadCount: unreadCount, dotWidth: dotW, txtFont: UIFont.systemFont(ofSize: 11))
    }

    func showUnreadMsgCount(unreadCount: Int, dotWidth: CGFloat, txtFont: UIFont) {
        self.layoutIfNeeded()
        //
        let offset: CGFloat = 1
        let dotView = UIView.init()
        dotView.setCornerRadius(dotWidth/2.0)
        dotView.backgroundColor = UIColor.red
        dotView.tag = 1992
        self.addSubview(dotView)
        //
        let superWidth = self.frame.size.width
        let x: CGFloat = superWidth - (dotWidth/2+offset)
        let y: CGFloat = -(dotWidth/2-offset)
        let rect: CGRect = CGRect.init(x: x, y: y, width: dotWidth, height: dotWidth)
        dotView.frame = rect
        //
        let label = UILabel.init()
        label.text = "\(unreadCount)"
        if unreadCount >= 99 {
            label.text = "99+"
        }
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.font = txtFont
        label.textAlignment = .center
        dotView.addSubview(label)
        //
        label.frame = dotView.bounds
    }

    func hiddenUnreadMsgDot() {
        let dotView = self.viewWithTag(1992)
        if dotView != nil {
            dotView!.removeFromSuperview()
        }
    }

    //MARK:- 系统提示声音
    /// 播放系统提示声音，1007类型QQ声音
    static func playSystemSoundNewMessage() {
        // https://www.jianshu.com/p/c41bbb020acb
        // 播放系统提示声音
        let soundID : SystemSoundID = 1007
        AudioServicesPlaySystemSound(soundID)
    }

    /// 播放系统提示声音，1004 消息发送成功。
    static func playSystemSoundSendMessage() {
        // 播放系统提示声音
        let soundID : SystemSoundID = 1004
        AudioServicesPlaySystemSound(soundID)
    }

    //MARK:- 打电话
    /// 拨打电话
    static func callPhone(_ phoneNum: String) {
        guard let url = URL(string: "tel:\(phoneNum)") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

}
