//
//  BaseViewController.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/8/25.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        configNavigationBar()
        adaptDynamicColor()
        setupUI()
    }
    
    /// 配置导航栏
    func configNavigationBar() {
        
    }
    
    /// 适配深色、浅色模式
    func adaptDynamicColor() {
        self.view.backgroundColor = UIColor.getDynamicColor(withLight: UIColor.init(hexString: "#F7F8FA"), dark: UIColor.white)
    }
    
    /// 界面初始化
    func setupUI() {
        
    }
    
}
