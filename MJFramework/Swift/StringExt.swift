//
//  StringExt.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/10/26.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import Foundation

extension String {
    
    /// 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
                                                            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    /// 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
