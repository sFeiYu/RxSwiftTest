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
    let disposebag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        demo1()
    }
    
    public func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    //MARK: - 连接操作符：connect、publish、replay、multicast
    func demo1() -> Void {
        //1.可连接的序列
        //可连接的序列和一般序列不同在于：有订阅时不会立刻开始发送事件消息，只有当调用 connect()之后才会开始发送值。
       //每隔1秒钟发送1个事件
        /********************************publish*******************************/
        //publish 方法会将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
        /*
       let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
           .publish()
                
       //第一个订阅者（立刻开始订阅）
       _ = interval
           .subscribe(onNext: { print("\(Date())订阅1: \($0)") })
        
       //相当于把事件消息推迟了两秒(2秒后才会打印订阅1)
       delay(2) {
           _ = interval.connect()
       }
        
       //第二个订阅者（延迟5秒开始订阅）
       delay(5) {
           _ = interval
               .subscribe(onNext: { print("\(Date())订阅2: \($0)") })
       }
 */
        
        /********************************replay*******************************/
        //replay 与 publish 不同在于：新的订阅者还能接收到订阅之前的事件消息（数量由设置的 bufferSize 决定）
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        .replay(5)
//        print("\(Date())我执行啦")
//
//        //第一个订阅者（立刻开始订阅）
//        _ = interval.subscribe(onNext: {print("\(Date())订阅1: \($0)")})
//
//        delay(2) {
//            //被延迟了2秒打印订阅1
//            _ = interval.connect()
//        }
//
//        //第二个订阅者（延迟5秒开始订阅）
//        //会接收0，1，2个信号
//        delay(5) {
//            _ = interval
//                .subscribe(onNext: { print("\(Date())订阅2: \($0)") })
//        }
        
        /********************************multicast*******************************/
        //同时 multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
        //创建一个Subject（后面的multicast()方法中传入）
        let subject = PublishSubject<Int>()
         
        //这个Subject的订阅
        _ = subject
            .subscribe(onNext: { print("Subject: \($0)") })
         
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .multicast(subject)
                 
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
         
        //相当于把事件消息推迟了两秒
        delay(2) {
            _ = interval.connect()
        }
         
        //第二个订阅者（延迟5秒开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
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
