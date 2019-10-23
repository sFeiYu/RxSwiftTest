//
//  Demo8.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/23.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//算数&聚合操作符
class Demo8: UIViewController {
    let disposebag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        /** toArray */
//        demo1()
        
        /** reduce */
//        demo2()
        
        /** concat */
        demo3()
        
    }
    
    func demo1() -> Void {
        //该操作符先把一个序列转成一个数组，并作为一个单一的事件发送，然后结束。
        Observable.of(1,2,3).toArray().subscribe(onSuccess: {print($0)}, onError: nil)
        .disposed(by: disposebag)
    }
    
    func demo2() -> Void {
        //reduce 将给定的初始值，与序列里的每个值进行累计运算。得到一个最终结果，并将其作为单个值发送出去。
        Observable.of(1,2,3)
        .reduce(0, accumulator: +)
        .subscribe(onNext: {print($0)})
        .disposed(by: disposebag)
    }
    
    func demo3() -> Void {
        //concat 会把多个 Observable 序列合并（串联）为一个 Observable 序列。
        //并且只有当前面一个 Observable 序列发出了 completed 事件，才会开始发送下一个 Observable 序列事件。
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = Variable(subject1)
        variable.asObservable()
        .concat()
        .subscribe(onNext: {print($0)})
        .disposed(by: disposebag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()
        
        variable.value = subject2
        subject2.onNext(2)
        
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
