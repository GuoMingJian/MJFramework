//
//  MJTools.swift
//  MicroCoupletTaxi
//
//  Created by 郭明健 on 2020/8/22.
//  Copyright © 2020 GuoMingJian. All rights reserved.
//

import UIKit
import AudioToolbox

/// 项目常用方法
class MJTools: NSObject {
    //MARK:- 常用方法
    
    /// 富文本
    static func setAttributes(label: UILabel,
                              subStrList: Array<String>,
                              color: UIColor) {
        let text: String = label.text!
        let font: UIFont = label.font
        let attM: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        for str in subStrList {
            var rangeList: Array<NSRange> = Array.init()
            var supStr = text
            var index: Int = 0
            while supStr.count > 0 {
                if supStr.contains(str) {
                    var range = (supStr as NSString).range(of: str)
                    supStr = (supStr as NSString).substring(from: range.location + range.length)
                    //
                    range.location += index
                    index = range.location + range.length
                    rangeList.append(range)
                } else {
                    supStr = ""
                }
            }
            //
            let att = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color]
            for range in rangeList {
                attM.addAttributes(att, range: range)
            }
        }
        label.attributedText = attM
    }
    
    /// Dictionary -> Data
    static func dictionaryToData(jsonDic:Dictionary<String, Any>) -> Data? {
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("解析失败：不是一个有效的json对象！")
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        //Data转换成String打印输出
        //let str = String(data:data!, encoding: String.Encoding.utf8)
        //输出json字符串
        //print("Json Str:\(str!)")
        return data
    }
    
    /// Data -> Dictionary
    static func dataToDictionary(data:Data) -> Dictionary<String, Any>? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as! Dictionary<String, Any>
            return dic
        } catch _ {
            print("Data -> Dictionary 解析失败！")
            return nil
        }
    }
    
    //MARK:- 二维码生成
    
    /// 二维码生成
    func setupQRCodeImage(_ text: String,
                          image: UIImage?) -> UIImage {
        //创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        //将url加入二维码
        filter?.setValue(text.data(using: String.Encoding.utf8), forKey: "inputMessage")
        //取出生成的二维码（不清晰）
        if let outputImage = filter?.outputImage {
            //生成清晰度更好的二维码
            let qrCodeImage = setupHighDefinitionUIImage(outputImage, size: 300)
            //如果有一个头像的话，将头像加入二维码中心
            if var image = image {
                // 白色圆边
                // image = circleImageWithImage(image, borderWidth: 50, borderColor: UIColor.white)
                // 白色圆角矩形边
                image = rectangleImageWithImage(image, borderWidth: 50, borderColor: UIColor.white)
                //合成图片
                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: 70, height: 70)
                
                return newImage
            }
            return qrCodeImage
        }
        //
        return UIImage()
    }
    
    /// 生成高清的UIImage
    func setupHighDefinitionUIImage(_ image: CIImage,
                                    size: CGFloat) -> UIImage {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion)
        bitmapRef.draw(bitmapImage, in: integral)
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }
    
    /// 生成矩形边框
    func rectangleImageWithImage(_ sourceImage: UIImage,
                                 borderWidth: CGFloat,
                                 borderColor: UIColor) -> UIImage {
        let imageWidth = sourceImage.size.width + 2 * borderWidth
        let imageHeight = sourceImage.size.height + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        UIGraphicsGetCurrentContext()
        
        let bezierPath = UIBezierPath.init(roundedRect: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height), cornerRadius: 1)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    /// 生成圆形边框
    func circleImageWithImage(_ sourceImage: UIImage,
                              borderWidth: CGFloat,
                              borderColor: UIColor) -> UIImage {
        let imageWidth = sourceImage.size.width + 2 * borderWidth
        let imageHeight = sourceImage.size.height + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        UIGraphicsGetCurrentContext()
        
        let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width : sourceImage.size.height) * 0.5
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    /// image: 二维码 iconImage:头像图片 width: 头像的宽 height: 头像的宽
    func syntheticImage(_ image: UIImage, iconImage:UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size)
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
    
    //MARK:- 按钮添加下划线
    /// 按钮添加下划线
    func addLineToButton(btn: UIButton) {
        let text: String = btn.titleLabel?.text ?? ""
        //
        let str = NSMutableAttributedString(string: text)
        let strRange = NSRange.init(location: 0, length: str.length)
        // 此处必须转为NSNumber格式传给value，不然会报错
        let number = NSNumber(integerLiteral: NSUnderlineStyle.single.rawValue)
        //
        let lineColor: UIColor = btn.titleLabel!.textColor
        let font: UIFont = btn.titleLabel!.font
        //
        str.addAttributes([NSAttributedString.Key.underlineStyle: number,
                           NSAttributedString.Key.foregroundColor: lineColor,
                           NSAttributedString.Key.font: font], range: strRange)
        //
        btn.setAttributedTitle(str, for: UIControl.State.normal)
    }
    
    
    
    /// 播放系统提示声音，1007类型QQ声音
    func playSystemSoundNewMessage() {
        // https://www.jianshu.com/p/c41bbb020acb
        // 播放系统提示声音
        let soundID : SystemSoundID = 1007
        AudioServicesPlaySystemSound(soundID)
    }
    
    /// 播放系统提示声音，1004 消息发送成功。
    func playSystemSoundSendMessage() {
        // 播放系统提示声音
        let soundID : SystemSoundID = 1004
        AudioServicesPlaySystemSound(soundID)
    }
    
    //MARK:- 打电话
    
    /// 拨打电话
    func callPhone(_ phoneNum: String) {
        guard let url = URL(string: "tel:\(phoneNum)") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
