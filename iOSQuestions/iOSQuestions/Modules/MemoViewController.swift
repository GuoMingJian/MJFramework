//
//  MemoViewController.swift
//  iOSQuestions
//
//  Created by 郭明健 on 2021/4/1.
//

import UIKit

class MemoViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton.init(type: .custom)
        btn.setTitle("点我", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.orange
        self.view.addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 100, height: 45))
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
        }
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        //
        btn.showUnreadMsgCount(unreadCount: 5)
//        btn.showRedDot()
        let imageV = UIImageView.init(image: UIImage.init(named: "message"))
        self.view.addSubview(imageV)
        imageV.snp_makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20, height: 20))
            make.top.equalTo(300)
            make.centerX.equalToSuperview()
        }
        imageV.showUnreadMsgCount(unreadCount: 5, dotWidth: 13, txtFont: UIFont.systemFont(ofSize: 10))

    }
    
    override func setupUI() {
        self.title = "备忘录"
    }

    @objc func clickBtn(sender: UIButton) {
        sender.hiddenUnreadMsgDot()
//        sender.hiddenRedDot()
    }
    
}
