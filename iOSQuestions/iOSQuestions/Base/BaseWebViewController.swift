//
//  BaseWebViewController.swift
//  dossen_ portal
//
//  Created by 郭明健 on 2019/9/2.
//  Copyright © 2019 GuoMingJian. All rights reserved.
//

import UIKit
import WebKit

class BaseWebViewController: UIViewController {
    
    public var url : String?
    public var navTitle : String?
    public var isShowNavBar: Bool = true
    //
    public let kProgressViewHeight : CGFloat = 2
    public let kProgressViewColor : UIColor = UIColor.orange
    
    /// 进度条
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView.init(frame: .zero)
        /// 进度条颜色
        view.tintColor = kProgressViewColor
        /// 进度条背景色
        view.trackTintColor = UIColor.white
        return view
    }()
    
    /// WKWebView
    private lazy var myWebView : WKWebView = {
        //
        let view = WKWebView.init(frame: .zero)
        view.navigationDelegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    func createUI() {
        self.title = self.navTitle
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(myWebView)
        self.view.addSubview(progressView)
        // wkwebview 适配
        if #available(iOS 11.0, *) {
            self.myWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        // 进度条与WebView位置
        let top = isShowNavBar ? kNavigationH : kStatusBarH
        let x : CGFloat = 0
        let y : CGFloat = top
        let width : CGFloat = kScreenW
        var height : CGFloat = kProgressViewHeight
        var rect = CGRect.init(x: x, y: y, width: width, height: height)
        self.progressView.frame = rect
        //
        height = kScreenH - top
        rect = CGRect.init(x: x, y: y, width: width, height: height)
        self.myWebView.frame = rect
        //
        let requestUrl = URL.init(string: self.url!)
        let request = URLRequest(url: requestUrl!)
        myWebView.load(request)
        // 监听进度条
        myWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(myWebView.estimatedProgress), animated: true)
            if myWebView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    deinit {
        myWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
}

//MARK:- WKNavigationDelegate
extension BaseWebViewController : UIWebViewDelegate , WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //
    }
    
}
