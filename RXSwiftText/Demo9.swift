//
//  Demo9.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/23.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo9: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        demo1()
    }
    
    //MARK: - 连接操作符：connect、publish、replay、multicast
    func demo1() -> Void {
        //1.可连接的序列
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        _ = interval.subscribe(onNext: {print("订阅：\($0)")})
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
