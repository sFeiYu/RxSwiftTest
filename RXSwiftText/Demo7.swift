//
//  Demo7.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/23.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//结合操作（Combining Observables）,合并序列
class Demo7: UIViewController {
    let disposebag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
               
        /** startWith */
//        demo1()
        
        /** merge */
//        demo2()
        
        /** zip */
//        demo3()
        
        /** combineLatest */
//        demo4()
        
        /** withLatestFrom */
//        demo5()
        
        /** switchLatest */
        demo6()
    }
    

    func demo1() -> Void {
        //在2，3前面放一个1
        Observable.of(2,3)
        .startWith(1)
        .subscribe(onNext: {print($0)})
        .disposed(by: disposebag)
    }
    
    func demo2() -> Void {
        //该方法可以将多个（两个或两个以上的）Observable 序列合并成一个 Observable序列
        //只能放类型一致的，都是Int型
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        Observable.of(subject1,subject2)
            .merge()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposebag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(1)
    }
    
    func demo3() -> Void {
        
        //而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        Observable.zip(subject1,subject2){
            "\($0)\($1)"
        }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposebag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext("1")
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext("2")
    }
    
    func demo4() -> Void {
        //但与 zip 不同的是，每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并。
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        Observable.combineLatest(subject1,subject2){
            "\($0)\($1)"
        }
            .subscribe(onNext: {print($0)})
            .disposed(by: disposebag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext("1")
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext("2")
    }
    
    func demo5() -> Void {
        
        //该方法将两个 Observable 序列合并为一个。每当 self 队列发射一个元素时，便从第二个序列中取出最新的一个值。
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        subject1.withLatestFrom(subject2)
            .subscribe(onNext: {print($0)})
            .disposed(by: disposebag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext("1")
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext("2")
    }
    
    func demo6() -> Void {
        
        //比如本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        let variable = Variable(subject1)
        variable.asObservable()
        .switchLatest()
        .subscribe(onNext: {print($0)})
        .disposed(by: disposebag)
        
        subject1.onNext("B")
        subject1.onNext("C")
         
        //改变事件源
        variable.value = subject2
        subject1.onNext("D")
        subject2.onNext("2")
         
        //改变事件源
        variable.value = subject1
        subject2.onNext("3")
        subject1.onNext("E")
    }

}
