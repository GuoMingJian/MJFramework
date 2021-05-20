//
//  IOSViewController.swift
//  iOSQuestions
//
//  Created by 郭明健 on 2021/4/6.
//

import UIKit

class IOSViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var titleStr: String = ""
    public var fileName: String = ""
    public var fileType: String = ""
    //
    var dataSourceArray: Array<QuestionModel> = [QuestionModel]()
    let kJustExpandOne: Bool = false // 是否仅展开一条数据(搜索结果为多条时，会报错，建议多条展开！)
    let closeImage = UIImage.init(named: "right")
    let openImage = UIImage.init(named: "up")
    //
    var highlightedKeyword: String = ""
    var highlightedColor: UIColor = UIColor.orange
    //
    private lazy var searchView: SearchView = {
        let searchView = SearchView().initFromNib() as! SearchView
        return searchView
    }()
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
        // 注册Cell
        tableView.register(ProblemCell.classForCoder(), forCellReuseIdentifier: ProblemCell.description())
        tableView.register(AnswerCell.classForCoder(), forCellReuseIdentifier: AnswerCell.description())
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        dataSourceArray = getTextData()
        //
        searchView.searchBlock = { (keyword) in
            self.highlightedKeyword = keyword
            self.updateData(keyword: keyword)
        }
    }
    
    override func setupUI() {
        self.title = titleStr
        //
        self.view.addSubview(searchView)
        self.view.addSubview(myTableView)
        //
        searchView.snp_makeConstraints { (make) in
            let topH: CGFloat = kNavigationH
            make.top.equalTo(topH)
            make.left.right.equalToSuperview()
            make.height.equalTo(78)
        }
        myTableView.snp_makeConstraints { (make) in
            make.top.equalTo(searchView.snp_bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    /// 获取文本内容
    func getTextData() -> Array<QuestionModel> {
        var dataArr: Array<QuestionModel> = [QuestionModel]()
        //
        let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) ?? ""
        let content = try! String.init(contentsOfFile: filePath, encoding: String.Encoding.utf8)
        let contentArr = content.components(separatedBy: "#")
        for i in 1 ..< contentArr.count {
            let tempString = contentArr[i]
            let tempArr = tempString.components(separatedBy: "&")
            if tempArr.count > 1 {
                var problem : String = tempArr[0]
                var answer : String = tempArr[1]
                // 去掉末尾换行符
                problem = (problem as NSString).substring(to: problem.count-1)
                problem = "\(i)、\(problem)"
                answer = (answer as NSString).substring(to: answer.count-1)
                //
                let model = QuestionModel.init()
                model.isOpen = false
                model.problem = problem
                model.answer = answer
                model.rightImage = model.isOpen ? openImage : closeImage
                //
                dataArr.append(model)
            }
        }
        return dataArr
    }
    
    /// 根据搜索关键字更新数据源（是否展开，关键字高亮）
    func updateData(keyword: String) {
        dataSourceArray = getTextData()
        //
        var dataArr: Array<QuestionModel> = [QuestionModel]()
        for item in dataSourceArray {
            let model: QuestionModel = item
            let isProblemContain: Bool = (model.problem ?? "").contains(keyword)
            let isAnswerContain: Bool = (model.answer ?? "").contains(keyword)
            if isProblemContain || isAnswerContain {
                model.isOpen = true
            } else {
                model.isOpen = false
            }
            model.rightImage = model.isOpen ? openImage : closeImage
            if model.isOpen {
                dataArr.append(model)
            }
        }
        if dataArr.count == 0 {
            if keyword.count > 0 {
                MJTipsView.show("未搜索到满足条件内容！")
            }
        } else {
            //
            dataSourceArray = dataArr
        }
        myTableView.reloadData()
    }
    
}

extension IOSViewController {
    //MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = dataSourceArray[section]
        if !model.isOpen {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSourceArray[indexPath.section]
        //
        if indexPath.row == 0 {
            let cell: ProblemCell = tableView.dequeueReusableCell(withIdentifier: ProblemCell.description(), for: indexPath) as! ProblemCell
            cell.selectionStyle = .none
            //
            cell.contentLabel.text = model.problem
            cell.rightImageView.image = model.rightImage
            cell.bottomView.isHidden = model.isOpen
            // 高亮
            MJTools.setAttributes(label: cell.contentLabel, subStrList: [highlightedKeyword], color: highlightedColor)
            return cell
        } else {
            let cell: AnswerCell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.description(), for: indexPath) as! AnswerCell
            cell.selectionStyle = .none
            //
            cell.contentLabel.text = model.answer
            // 高亮
            MJTools.setAttributes(label: cell.contentLabel, subStrList: [highlightedKeyword], color: highlightedColor)
            return cell
        }
    }
    
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        //
        if indexPath.row == 0 {
            updateData(indexPath: indexPath)
        } else {
            let model = dataSourceArray[indexPath.section]
            let playText: String = model.answer ?? ""
            //
            if playText.count > 0 {
                let alertView: MJAlertView = MJAlertView.getAlertWithTitle("友情提示", content: "是否语音播报？", leftBtnText: "取消", rightBtnText: "确定") as! MJAlertView
                self.view.addSubview(alertView)
                alertView.clickButtonCallback = { (index, btn) in
                    if index == 1 {
                        MJSoundPlayer.shareInstance().stopPlayMsg()
                        MJSoundPlayer.shareInstance().playMsg(playText)
                    } else {
                        MJSoundPlayer.shareInstance().stopPlayMsg()
                    }
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    //MARK:-
    /// 展开折叠，更新数据
    func updateData(indexPath: IndexPath) {
        //
        if kJustExpandOne {
            // 显示单个
            for i in 0...dataSourceArray.count - 1 {
                let model = dataSourceArray[i]
                let originalState: Bool = model.isOpen
                var newState: Bool = originalState
                if i != indexPath.section {
                    newState = false
                } else {
                    newState = !originalState
                }
                model.isOpen = newState
                model.rightImage = model.isOpen ? openImage : closeImage
                dataSourceArray[i] = model
                //
                let newIndexPath = IndexPath.init(row: 1, section: i)
                if originalState && !newState {
                    // 关闭
                    myTableView.deleteRows(at: [newIndexPath], with: .automatic)
                }
                if !originalState && newState {
                    // 展开
                    myTableView.insertRows(at: [newIndexPath], with: .automatic)
                }
                // 状态改变
                if newState != originalState {
                    // 改变箭头icon
                    let cell: ProblemCell = myTableView.cellForRow(at: IndexPath.init(row: 0, section: i)) as! ProblemCell
                    cell.rightImageView.image = model.rightImage
                    cell.bottomView.isHidden = model.isOpen
                }
            }
        } else {
            // 可显示多个
            let model = dataSourceArray[indexPath.section]
            model.isOpen = !model.isOpen
            model.rightImage = model.isOpen ? openImage : closeImage
            //
            let newIndexPath = IndexPath.init(row: 1, section: indexPath.section)
            if model.isOpen {
                myTableView.insertRows(at: [newIndexPath], with: .automatic)
            } else {
                myTableView.deleteRows(at: [newIndexPath], with: .automatic)
            }
            // 改变箭头icon
            let cell: ProblemCell = myTableView.cellForRow(at: indexPath) as! ProblemCell
            cell.rightImageView.image = model.rightImage
            cell.bottomView.isHidden = model.isOpen
        }
    }
    
}

class ProblemCell: UITableViewCell {
    
    var contentLabel: UILabel!
    var rightImageView: UIImageView!
    var bottomView: UIView!
    //
    let rightImageName: String = "right"
    let rightIconSize: CGSize = CGSize.init(width: 16, height: 16)
    let contentFont: UIFont = UIFont.pfRegular(16)
    let contentColor: UIColor = UIColor.init(hexString: "#101010")
    let topSpac: CGFloat = 15
    let leftSpac: CGFloat = 16
    let lineColor: UIColor = UIColor.init(hexString: "#000000", alpha: 0.1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        bottomView = UIView.init()
        bottomView.backgroundColor = lineColor
        self.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        //
        rightImageView = UIImageView.init()
        rightImageView.image = UIImage.init(named: rightImageName)
        self.addSubview(rightImageView)
        rightImageView.snp_makeConstraints { (make) in
            make.size.equalTo(rightIconSize)
            make.right.equalToSuperview().offset(-leftSpac)
            make.centerY.equalToSuperview()
        }
        //
        contentLabel = UILabel.init()
        contentLabel.font = contentFont
        contentLabel.textColor = contentColor
        contentLabel.numberOfLines = 0
        self.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) in
            make.top.equalTo(topSpac)
            make.left.equalTo(leftSpac)
            make.right.equalTo(rightImageView.snp_left)
            make.bottom.equalTo(bottomView.snp_top).offset(-topSpac)
        }
    }
}

class AnswerCell: UITableViewCell {
    
    var contentLabel: UILabel!
    var bottomView: UIView!
    //
    let rightIconSize: CGSize = CGSize.init(width: 16, height: 16)
    let contentFont: UIFont = UIFont.pfRegular(16)
    let contentColor: UIColor = UIColor.init(hexString: "#939496")
    let bottomSpac: CGFloat = 11
    let leftSpac: CGFloat = 16
    let lineColor: UIColor = UIColor.init(hexString: "#000000", alpha: 0.1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        bottomView = UIView.init()
        bottomView.backgroundColor = lineColor
        self.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        //
        contentLabel = UILabel.init()
        contentLabel.font = contentFont
        contentLabel.textColor = contentColor
        contentLabel.numberOfLines = 0
        self.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(leftSpac)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bottomView.snp_top).offset(-bottomSpac)
        }
    }
}
