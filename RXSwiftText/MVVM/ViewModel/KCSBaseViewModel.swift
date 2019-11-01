//
//  KCSBaseViewModel.swift
//  KCSwift
//
//  Created by KnowChat03 on 2019/10/31.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

import UIKit

class KCSBaseViewModel: NSObject {
    var disposeBag = DisposeBag()
    //输入转化输出，这里是真正的业逻辑代码
//    func transform(input:Input) -> Output {
//
//    }
}

extension KCSBaseViewModel {
    //输入，类型是Driver, 因为跟UI控件有关
    struct Input {
        
    }
    
    //输出，类型也是Driver
    struct Output {
        
    }
}


