//
//  BaseNavigationController.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/8/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit

public var backImageName = "back.png"

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    static var speaceItem: UIBarButtonItem = {
        let speaceItem = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        speaceItem.width = 8
        return speaceItem
    }()
    
    static var backItem: UIBarButtonItem = {
        return BaseNavigationController().getBackItem(imgName: backImageName)
    }()
    
    /// 导航栏返回block
    public var backBlock: (()->())?
    
    func getBackItem(imgName: String) -> UIBarButtonItem {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let img = UIImage.init(named: imgName)
        btn.setImage(img, for: .normal)
        btn.setImage(img, for: .highlighted)
        btn.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
        //
        let backItem = UIBarButtonItem.init(customView: btn)
        return backItem
    }
    
    @objc func clickCloseButton() {
        if backBlock != nil {
            //print("自定义处理返回。")
            backBlock!()
        } else {
            if viewControllers.count > 0 {
                self.popViewController(animated: true)
            }
        }
    }
    
    //MARK:-
    /// 右划返回手势
    private var popDelegate: UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.shadowImage = UIImage() // 阴影线
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(hexString: "#000000"), .font: UIFont.pfMedium(17)]
        //添加阴影
        self.navigationBar.layer.shadowColor = UIColor.init(hexString: "#000000", alpha: 0.1).cgColor
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.navigationBar.layer.shadowOpacity = 1
        self.navigationBar.layer.shadowRadius = 11
        //
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItems = [BaseNavigationController.speaceItem, BaseNavigationController.backItem]
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    //MARK:- 自定义导航栏：改变状态栏颜色
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //滑动返回
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer?.delegate = self.popDelegate
        } else {
            self.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
}
