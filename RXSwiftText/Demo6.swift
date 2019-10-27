//
//  Demo6.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/23.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//条件和布尔操作
class Demo6: UIViewController {
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        /** amb */
//        demo1()
        /** takeWhile */
//        demo2()
        /** takeUntil */
//        demo3()
        /** skipWhile */
//        demo4()
        /** skipUntil */
//        demo5()
        
        //take的相关方法和skip的正好相反
    }
    
    func demo1() -> Void {
        //当传入多个 Observables 到 amb 操作符时，它将取第一个发出元素或产生事件的 Observable，然后只发出它的元素。并忽略掉其他的 Observables。
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        let subject3 = PublishSubject<Int>()
        
        subject1
            .amb(subject2)
            .amb(subject3)
            .subscribe(onNext: {print($0)})
            .disposed(by: disposebag)
        //此时subject1，subject2，subject3都传入到了amb操作符
        //因为subject2第一个发送消息，所以只打印subject2的内容
        subject2.onNext(1)
        subject1.onNext(20)
        subject2.onNext(2)
        subject1.onNext(40)
        subject3.onNext(0)
        subject2.onNext(3)
        subject1.onNext(60)
        subject3.onNext(0)
        subject3.onNext(0)
        
    }
    
    func demo2() -> Void {
        //该方法依次判断 Observable 序列的每一个值是否满足给定的条件。 当第一个不满足条件的值出现时，它便自动完成。
        Observable.of(2,3,4,5,6)
            .takeWhile{ $0 < 4}
            .subscribe(onNext: { print($0)} )
            .disposed(by: disposebag)
        
    }
    
    func demo3() -> Void {
        /*
         除了订阅源 Observable 外，通过 takeUntil 方法我们还可以监视另外一个 Observable， 即 notifier。
         如果 notifier 发出值或 complete 通知，那么源 Observable 便自动完成，停止发送事件。
         */
        let source = PublishSubject<String>()
        let notifier = PublishSubject<String>()
        source
        .takeUntil(notifier)
        .subscribe(onNext: {print($0)})
        .disposed(by: disposebag)
        
        source.onNext("a")
        source.onNext("b")
        source.onNext("c")
        source.onNext("d")
        //停止接收消息
        notifier.onNext("z")//!!!!!
        source.onNext("e")
        source.onNext("f")
        source.onNext("g")
        
    }
    
    func demo4() -> Void {
        Observable.of(2,3,4,5,6)
            .skipWhile{$0 < 4}//只有满足这个条件的不打印
            .subscribe(onNext: {print($0)})
            .disposed(by: disposebag)
        
    }
    
    func demo5() -> Void {
        let source = PublishSubject<String>()
        let notifier = PublishSubject<String>()
        source
            .skipUntil(notifier)
            .subscribe(onNext: {print($0)})
            .disposed(by: disposebag)
        
        source.onNext("a")
        source.onNext("b")
        source.onNext("c")
        source.onNext("d")
        //开始接收消息
        notifier.onNext("z")//!!!!!
        source.onNext("e")
        source.onNext("f")
        source.onNext("g")
    }
    
    

}

