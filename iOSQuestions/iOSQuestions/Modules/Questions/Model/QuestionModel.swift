//
//  QuestionModel.swift
//  iOSQuestions
//
//  Created by 郭明健 on 2021/4/6.
//

import UIKit

class QuestionModel: BaseModel {
    var isOpen: Bool = true
    var problem: String?
    var answer: String?
    var rightImage: UIImage?
}
