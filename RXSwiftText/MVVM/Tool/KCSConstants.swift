//
//  KCSConstants.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/11/1.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit

func IPHONEX_INSETS()->UIEdgeInsets{
    
    if #available(iOS 11.0, *) {
        if UIApplication.shared.keyWindow == nil ||
            UIApplication.shared.keyWindow?.safeAreaInsets.top == 0{
            return UIEdgeInsets(top: UIApplication.shared.statusBarFrame.size.height, left: 0, bottom: 0, right: 0)
        }else{
            return UIApplication.shared.keyWindow!.safeAreaInsets;
        }
    } else {
       return UIEdgeInsets(top: UIApplication.shared.statusBarFrame.size.height, left: 0, bottom: 0, right: 0)
    }
}


class KCSConstants: NSObject {

}
