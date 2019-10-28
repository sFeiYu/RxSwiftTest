//
//  Demo2.swift
//  RXSwiftText
//
//  Created by 钱飞英 on 2019/10/20.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo2: ViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //可观察序列 - Sequence
        //有限 - 有穷
        //有穷
        let ob = Observable.just([1,2,3,4])
        ob.subscribe(onNext: { (num) in
            print(num)
        }, onCompleted: {
            print("订阅完成")
        })
            .disposed(by: disposeBag)
        //失败
        URLSession.shared.rx.response(request: URLRequest(url: URL(string: "")!)).subscribe(onNext: { (response, data) in
            
        }, onError: { (error) in
            
            }).disposed(by: disposeBag)
        
        //无穷：
        //timer定时器
 */
        
        //原理
//        UIControl.addTarget(rx内部)
//        类 #selector{observer.onNext()}
        
        /*************************************/
        //1.创建序列
        let ob = Observable<Any>.create { (obserber) -> Disposable in
            //3.发送信号
            obserber.onNext("框架")
//            obserber.onError(NSError.init(domain: "error1", code: 10087, userInfo: nil))
            obserber.onCompleted()
            return Disposables.create()
        }
        //2.订阅
        let _ = ob.subscribe(onNext: { (anyObject) in
            print("订阅到\(anyObject)")
        }, onError: { (error) in
            print("error:\(error)")
        }, onCompleted: {
            print("完成")
        }) {
            print("销毁")
        }
    }
    

}
