//
//  Demo5.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/22.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo5: UIViewController {
    
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //单个信号序列创建
        //ViewModel create(网络请求) data -> Observable(data)
        //tableview数组 - ViewModel.ob.subscriber {data in 数组}
        let array = ["aa", "bb"]
        Observable<[String]>.just(array).subscribe(onNext: { (str) in
            print(str)
            }).disposed(by: disposebag)
       
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
