//
//  KCSExtension.swift
//  KCSwift
//
//  Created by KnowChat03 on 2019/8/26.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

import Foundation
import UIKit

//MARK: - NSObject

extension NSObject {
    // MARK:返回className
    var className:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
            
        }
    }
    
}

//MARK: - String

extension String {
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    
    
}


extension UIView {
    func viewController()-> UIViewController?{
        var nextView:UIView? = self
        repeat{
            let nextResponder = nextView?.next
            if (nextResponder?.isKind(of: UIViewController.self))!{
                return (nextResponder as! UIViewController)
            }
            nextView = nextView?.superview
        }while nextView != nil
        
        return nil
    }
}

//MARK: - UIColor

extension UIColor {
    
    
    /// 自定义颜色
    ///
    /// - Parameter hexString: 色值
    /// - Returns: color
    @objc class func colorCustom(hexString:String) -> UIColor {
        return UIColor.colorCustom(hexString: hexString, alpha: 1)
    }
    
    @objc class func colorCustom(hexString:String, alpha:CGFloat) -> UIColor {
        var cString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if cString.count < 6 {
            return UIColor.clear
        }
        if cString.hasPrefix("0X") {
            cString = cString.substring(fromIndex: 2)
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(fromIndex: 1)
        }
        let scanner = Scanner(string: cString)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        return UIColor(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha)
    }
    
    
    
    
    
}

//MARK: - UIImage

enum IHGradientChangeDirection {
    case Level
    case Vertical
    case UpwardDiagonalLine
    case DownDiagonalLine
}
extension UIImage {
    //纯色转UIImage
    @objc class func colorToImage(color:UIColor) -> UIImage {
        let imageSize = CGSize.init(width: 4, height: 4)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        color.set()
        UIRectFill(CGRect.init(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let pressedColorImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return pressedColorImg!
    }
    
    class func bm_ImageGradientChange(size:CGSize, direction:IHGradientChangeDirection, startcolor:UIColor?, endColor:UIColor?, cornerRadius:CGFloat) -> UIImage? {
        if (size == .zero || startcolor == nil || endColor == nil) {
            return nil;
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var startPoint:CGPoint = .zero;
        if (direction == .DownDiagonalLine) {
            startPoint = CGPoint(x: 0, y: 1)
        }
        gradientLayer.startPoint = startPoint;
        var endPoint:CGPoint = .zero;
        switch (direction) {
        case .Level:
            endPoint = CGPoint(x:1.0, y:0.0);
                break;
        case .Vertical:
            endPoint = CGPoint(x:0.0, y:1.0);
                break;
        case .UpwardDiagonalLine:
            endPoint = CGPoint(x:1.0, y:1.0);
                break;
        case .DownDiagonalLine:
            endPoint = CGPoint(x:1.0, y:0.0);
                break;
            default:
                break;
        }
        gradientLayer.endPoint = endPoint;
        if (cornerRadius > 0) {
            gradientLayer.cornerRadius = cornerRadius;
            gradientLayer.masksToBounds = true;
        }
        gradientLayer.colors = [startcolor?.cgColor, endColor?.cgColor]
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return image;
    }
}

//MARK: - NSNotification.Name
extension NSNotification.Name{
    
   
    //强退消息
    static var cUserForceQuitNotification:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "cUserForceQuitNotification")
    }
    
    static var NotifSendStateChange:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifSendStateChange")
    }
    
    static var NotifRefreshMessageList:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifRefreshMessageList")
    }
    
    static var NotifReceiveMainMessage:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifReceiveMainMessage")
    }
    
    static var NotifRingPlay:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifRingPlay")
    }
    
    static var NotifReceiveDetaiMessage:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifReceiveDetaiMessage")
    }
    
    //被踢下线
    static var NotifUserForceQuit:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifUserForceQuit")
    }
    
    //强制升级
    static var NotifForceUpdate:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifForceUpdate")
    }
    
    //禁止登录
    static var NotifUserLoginForbid:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifUserLoginForbid")
    }
    
    //通讯消息
    static var NotifNoticeCall:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifNoticeCall")
    }
    
    static var NotifCallFromPay:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifCallFromPay")
    }
    
    static var NotifNoticeConnectError:NSNotification.Name {
        return NSNotification.Name.init(rawValue: "NotifNoticeConnectError")
    }
    
    
  
}

//MARK: - UIDevice
//手机型号
public extension UIDevice{
    var modelName:String{
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror.init(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1":                              return "iPhone iPhone 8"
        case "iPhone10,4":                              return "iPhone iPhone 8"
        case "iPhone10,2":                              return "iPhone iPhone 8 Plus"
        case "iPhone10,5":                              return "iPhone iPhone 8 Plus"
        case "iPhone10,3":                              return "iPhone X"
        case "iPhone10,6":                              return "iPhone X"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4":                              return "iPhone XS Max"
        case "iPhone11,6":                              return "iPhone XS Max"
        case "iPhone12,1":                              return "iPhone 11"
        case "iPhone12,3":                              return "iPhone 11 Pro"
        case "iPhone12,5":                              return "iPhone 11 Pro Max"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
        
    }
}

