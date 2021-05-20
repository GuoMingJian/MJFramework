//
//  BaseTabBarViewController.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/8/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    
    // 定义样式
    let font = UIFont.pfRegular(11)
    let textColor_normal = UIColor.init(hexString: "#1F2240")
    let textColor_selected = UIColor.init(hexString: "#4646E6")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    func createUI() {
        addChild(QuestionsViewController(),
                 title: "面试题",
                 normalImageName: "1_normal",
                 selectedImageName: "1_selected")
        addChild(MemoViewController(),
                 title: "备忘录",
                 normalImageName: "2_normal",
                 selectedImageName: "2_selected")
        addChild(MineViewController(),
                 title: "个人中心",
                 normalImageName: "3_normal",
                 selectedImageName: "3_selected")
        //
        self.delegate = self
        self.selectedIndex = 0
        //移除顶部线条
        self.tabBar.shadowImage = UIImage()
        //设置背景图片
        self.tabBar.backgroundImage = UIImage.init(color: UIColor.white)
        //添加阴影
        self.tabBar.layer.shadowColor = UIColor.init(hexString: "#EEEEEE", alpha: 0.5).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.shadowRadius = 6
    }
    
    func addChild(_ viewController: UIViewController,
                  title: String,
                  normalImageName: String,
                  selectedImageName: String) {
        //
        let navVC = BaseNavigationController.init(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.setTitleTextAttributes([.foregroundColor: textColor_normal, .font : font], for: .normal)
        viewController.tabBarItem.setTitleTextAttributes([.foregroundColor : textColor_selected, .font : font], for: .selected)
        viewController.tabBarItem.image = UIImage(named: normalImageName)?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        //
        self.addChild(navVC)
    }
    
}

//MARK:- UITabBarControllerDelegate

extension BaseTabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
