//
//  BaseModel.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/8/20.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit
import HandyJSON

class BaseModel: HandyJSON {
    
    var code : Int = -1  // 201成功
    var message : String = ""
    
    required init() {}
    
}
