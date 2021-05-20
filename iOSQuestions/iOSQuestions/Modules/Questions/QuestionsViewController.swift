//
//  QuestionsViewController.swift
//  iOSQuestions
//
//  Created by 郭明健 on 2021/4/1.
//

import UIKit
import SnapKit

class QuestionsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var myTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.init(hexString: "#F7F8FA")
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = true
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        //
        tableView.dataSource = self
        tableView.delegate = self
        //
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        return tableView
    }()
    
    private var questionArrayM: Array<FileModel> = [FileModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        initData()
    }
    
    override func setupUI() {
        self.title = "面试题"
        //
        self.view.addSubview(myTableView)
        myTableView.snp_makeConstraints { (make) in
            let topH: CGFloat = kNavigationH
            make.top.equalTo(topH)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    /// 初始化数据源
    func initData() {
        var model: FileModel = FileModel.init()
        model.title = "iOS面试题"
        model.fileName = "iOS"
        questionArrayM.append(model)
        model = FileModel.init()
        model.title = "iOS高级面试题"
        model.fileName = "iOS2"
        questionArrayM.append(model)
        model = FileModel.init()
        model.title = "Swift面试题"
        model.fileName = "Swift"
        questionArrayM.append(model)
    }
    
}

extension QuestionsViewController {
    //MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionArrayM.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.selectionStyle = .none
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.groupTableViewBackground
        cell.addSubview(lineView)
        lineView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        //
        let model: FileModel = questionArrayM[indexPath.row]
        cell.textLabel?.text = model.title
        //
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: FileModel = questionArrayM[indexPath.row]
        //
        let iOSVC = IOSViewController.init()
        iOSVC.titleStr = model.title ?? ""
        iOSVC.fileName = model.fileName ?? ""
        iOSVC.fileType = model.fileType
        self.navigationController?.pushViewController(iOSVC, animated: true)
    }
}
