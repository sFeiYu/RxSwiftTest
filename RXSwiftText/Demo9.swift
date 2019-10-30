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
//        let subject = PublishSubject<Int>()
//
//        //这个Subject的订阅
//        _ = subject
//            .subscribe(onNext: { print("Subject: \($0)") })
//
//        //每隔1秒钟发送1个事件
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//            .multicast(subject)
//
//        //第一个订阅者（立刻开始订阅）
//        _ = interval
//            .subscribe(onNext: { print("订阅1: \($0)") })
//
//        //相当于把事件消息推迟了两秒
//        delay(2) {
//            _ = interval.connect()
//        }
//
//        //第二个订阅者（延迟5秒开始订阅）
//        delay(5) {
//            _ = interval
//                .subscribe(onNext: { print("订阅2: \($0)") })
//        }
        
        /********************************refCount*******************************/
        
        //refCount 操作符可以将可被连接的 Observable 转换为普通 Observable
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//            .publish()
//            .refCount()
//
//        //第一个订阅者（立刻开始订阅）
//        _ = interval
//            .subscribe(onNext: { print("订阅1: \($0)") })
//
//        //第二个订阅者（延迟5秒开始订阅）
//        delay(5) {
//            _ = interval
//                .subscribe(onNext: { print("订阅2: \($0)") })
//        }
            
        /********************************share(relay:)*******************************/
        //该操作符将使得观察者共享源 Observable，并且缓存最新的 n 个元素，将这些元素直接发送给新的观察者。
        //简单来说 shareReplay 就是 replay 和 refCount 的组合。
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                .share(replay: 3)
             
            //第一个订阅者（立刻开始订阅）
            _ = interval
                .subscribe(onNext: { print("订阅1: \($0)") })
             
            //第二个订阅者（延迟5秒开始订阅）
            delay(5) {
                _ = interval
                    .subscribe(onNext: { print("订阅2: \($0)") })
            }
        
        }
    
    //MARK: - 其他一些实用的操作符（Observable Utility Operators）
    func demo2() -> Void {
        /********************************delay*******************************/
        //该操作符会将 Observable 的所有元素都先拖延一段设定好的时间，然后才将它们发送出来。
        Observable.of(1, 2, 1)
                   .delay(3, scheduler: MainScheduler.instance) //元素延迟3秒才发出
                   .subscribe(onNext: { print($0) })
                   .disposed(by: disposebag)
        
        /********************************delaySubscription*******************************/
        //使用该操作符可以进行延时订阅。即经过所设定的时间后，才对 Observable 进行订阅操作。
//        Observable.of(1,2,1)
//            .delaySubscription(3, scheduler: MainScheduler.instance)
//            .subscribe(onNext: {print($0)})
//            .disposed(by: disposebag)
        
    
        /********************************materialize*******************************/
        //该操作符可以将序列产生的事件，转换成元素。
        //发出的是序列
//        Observable.of(1, 2, 1)
//                   .materialize()
//                   .subscribe(onNext: { print($0) })
//                   .disposed(by: disposebag)
        //打印的是next(1)...
        
        /********************************dematerialize*******************************/
        //该操作符的作用和 materialize 正好相反，它可以将 materialize 转换后的元素还原
        
        /********************************timeout*******************************/
        //使用该操作符可以设置一个超时时间。如果源 Observable 在规定时间内没有发任何出元素，就产生一个超时的 error 事件。
        
        /********************************using*******************************/
        //使用 using 操作符创建 Observable 时，同时会创建一个可被清除的资源，一旦 Observable终止了，那么这个资源就会被清除掉了
        
    }
    
    //MARK: - 误处理操作（Error Handling Operators）
    
    func demo3() -> Void {
        /********************************catchErrorJustReturn*******************************/
        //当遇到 error 事件的时候，就返回指定的值，然后结束。
//        let sequenceThatFails = PublishSubject<String>()
//        sequenceThatFails
//            .catchErrorJustReturn("错误")
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposebag)
        
        /********************************catchError*******************************/
        //该方法可以捕获 error，并对其进行处理。
        //同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）。
        
//        let sequenceThatFails = PublishSubject<String>()
//        let recoverySequence = Observable.of("1", "2", "3")
//
//        sequenceThatFails
//            .catchError {
//                print("Error:", $0)
//                return recoverySequence
//            }
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposebag)
        
        /********************************retry*******************************/
        //使用该方法当遇到错误的时候，会重新订阅该序列。比如遇到网络请求失败时，可以进行重新连接。
        //retry() 方法可以传入数字表示重试次数。不传的话只会重试一次。
        
//        sequenceThatErrors
//        .retry(2)  //重试2次（参数为空则只重试一次）
//        .subscribe(onNext: { print($0) })
//        .disposed(by: disposeBag)
    }
    
    //MARK: - 调试操作
    func demo4() -> Void {
        /********************************debug*******************************/
        //我们可以将 debug 调试操作符添加到一个链式步骤当中，这样系统就能将所有的订阅者、事件、和处理等详细信息打印出来，方便我们开发调试
        Observable.of("2", "3")
        .startWith("1")
        .debug("调试1")//标记参数
        .subscribe(onNext: { print($0) })
        .disposed(by: disposebag)
        
        /********************************RxSwift.Resources.total*******************************/
        //通过将 RxSwift.Resources.total 打印出来，我们可以查看当前 RxSwift 申请的所有资源数量。这个在检查内存泄露的时候非常有用。
        
//        print(RxSwift.Resources.total)
//
//        let disposeBag = DisposeBag()
//
//        print(RxSwift.Resources.total)
//
//        Observable.of("BBB", "CCC")
//            .startWith("AAA")
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposebag)
//
//        print(RxSwift.Resources.total)
    }
    
    //MARK: - 特征序列1：Single、Completable、Maybe
    //Observable 是能够用于任何上下文环境的通用序列。
    //而 Traits 可以帮助我们更准确的描述序列。同时它们还为我们提供上下文含义、语法糖，让我们能够用更加优雅的方式书写代码。
    func demo5() -> Void {
        /********************************Single*******************************/
        //发出一个元素，或一个 error 事件
        //不会共享状态变化
        //使用(网络请求)
        let ob = getPlaylist("aa")
        ob.subscribe { (event) in
            switch event {
            case .success(let json):
                print("JSON结果: ", json)
            case .error(let error):
                print("发生错误: ", error)
            }
        }.disposed(by: disposebag)
        
        //.asSingle()
        Observable.of("1")
        .asSingle()
        .subscribe({ print($0) })
        .disposed(by: disposebag)
        
        /********************************Completable*******************************/
        //不会发出任何元素
        //只会发出一个 completed 事件或者一个 error 事件
        //不会共享状态变化
        //本地存储
        cacheLocally()
        
        
        /********************************Maybe*******************************/
        //发出一个元素、或者一个 completed 事件、或者一个 error 事件
        //不会共享状态变化
        generateString()
        
    }
    
    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                 
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data,
                                                                 options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                 
                single(.success(result))
            }
             
            task.resume()
             
            return Disposables.create { task.cancel() }
        }
    }
            
    //与数据相关的错误类型
    enum DataError: Error {
        case cantParseJSON
    }
    
    
    //将数据缓存到本地
    func cacheLocally() -> Completable {
    
        return Completable.create { completable in
            //将数据缓存到本地（这里掠过具体的业务代码，随机成功或失败）
            let success = (arc4random() % 2 == 0)
             
            guard success else {
                completable(.error(CacheError.failedCaching))
                return Disposables.create {}
            }
             
            completable(.completed)
            return Disposables.create {}
        }
    }
     
    //与缓存相关的错误类型
    enum CacheError: Error {
        case failedCaching
    }
    
   func generateString() -> Maybe<String> {
       return Maybe<String>.create { maybe in
            
           //成功并发出一个元素
           maybe(.success("hangge.com"))
            
           //成功但不发出任何元素
           maybe(.completed)
            
           //失败
           //maybe(.error(StringError.failedGenerate))
            
           return Disposables.create {}
       }
   }
    
   //与缓存相关的错误类型
   enum StringError: Error {
       case failedGenerate
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
