//
//  SearchView.swift
//  iOSQuestions
//
//  Created by 郭明健 on 2021/4/6.
//

import UIKit

class SearchView: UIView, UITextFieldDelegate {

    @IBOutlet weak var searchBgView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    //
    public var searchBlock: ((_ keywork: String)->())?
    /// 高亮关键字
    var highlightedKeyword: String = "" {
        didSet {
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //
        searchBgView.setCornerRadius(8)
        searchBgView.setBorderWidth(1, borderColor: UIColor.init(hexString: "#CDCDCD"))
        //
        searchTextField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        searchTextField.returnKeyType = .search
        searchTextField.delegate = self
    }

    //MARK:- actions
    /// 搜索
    @IBAction func clickSearchButton(_ sender: UIButton) {
        searchTextField.resignFirstResponder()
        highlightedKeyword = searchTextField.text ?? ""
        //
        if searchBlock != nil {
            searchBlock!(highlightedKeyword)
        }
    }

    @objc func textDidChange(_ textField: UITextField) {
        highlightedKeyword = textField.text ?? ""
        //
        if searchBlock != nil {
            searchBlock!(highlightedKeyword)
        }
    }

    //MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.clickSearchButton(UIButton.init())
        return true
    }

}
