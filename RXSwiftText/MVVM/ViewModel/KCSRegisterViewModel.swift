//
//  KCSRegisterViewModel.swift
//  KCSwift
//
//  Created by KnowChat03 on 2019/11/1.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

import UIKit

//验证结果和信息的枚举
enum ValidationResult {
    case validating
    case empty
    case ok(message:String)
    case failed(message:String)
}

extension ValidationResult {
    var isValid:Bool{
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension ValidationResult:CustomStringConvertible {
    var description: String {
        switch self {
        case .validating:
            return "正在验证..."
        case .empty:
            return ""
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }
}

extension ValidationResult {
    var textColor:UIColor {
        switch self {
        case .validating:
            return UIColor.gray
        case .empty:
            return UIColor.black
        case .ok:
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1)
        case .failed:
            return UIColor.red
        }
    }
}


//MARK: -

class KCSRegisterViewModel: KCSBaseViewModel {
    
    
    
}
