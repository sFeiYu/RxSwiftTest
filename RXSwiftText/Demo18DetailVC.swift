//
//  Demo18DetailVC.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/28.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo18DetailVC: UIViewController {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Driver
    //Driver 可以说是最复杂的 trait，它的目标是提供一种简便的方式在 UI 层编写响应式代码。
    func demo1() -> Void {
        /********************************Driver*******************************/
        /*
        如果我们的序列满足如下特征，就可以使用它：

        不会产生 error 事件
        一定在主线程监听（MainScheduler）
        共享状态变化（shareReplayLatestWhileConnected）
         */
        
    }
    
    //MARK: - 特征序列3：ControlProperty、 ControlEvent
    /*
     （1）ControlProperty 是专门用来描述 UI 控件属性，拥有该类型的属性都是被观察者（Observable）。

     （2）ControlProperty 具有以下特征：

     不会产生 error 事件
     一定在 MainScheduler 订阅（主线程订阅）
     一定在 MainScheduler 监听（主线程监听）
     共享状态变化

     */
    func demo2() -> Void {
        
    }
    
    


}
