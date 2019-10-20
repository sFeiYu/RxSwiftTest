//
//  Demo1VC.swift
//  RXSwiftTest
//
//  Created by 钱飞英 on 2019/10/18.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo1VC: ViewController {
    
    var person = NewPerson()
    
    let btn = UIButton(type: .custom)
    let txf = UITextField()
    let scw = UIScrollView()
    var timer:Observable<Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        test1()
    }
    
    func test1() -> Void {
        let array = [1,2,3,4,5,6]
        //FRP
        //函数式
        array.filter {$0 > 3}
            .filter {( $0+1)%2==0}
            .forEach{print($0)}
        
        //响应式
        self.person.rx.observeWeakly(String.self, "name")
            .subscribe(onNext: { (value) in
                print(value!)
            }).disposed(by: disposeBag)
        
        //UI层响应式编程
        /********UIButton***********/
//        self.btn.rx.tap
//            .subscribe(onNext: { ()in
//
//            }).disposed(by: disposeBag)
        
        self.btn.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { () in
                
            }).disposed(by: disposeBag)
        
        /********UITextField***********/
        self.txf.rx.text.orEmpty.subscribe(onNext: { (text) in
                print(text)
            }).disposed(by: disposeBag)
        
        txf.rx.text
            .bind(to: self.btn.rx.title())
            .disposed(by: disposeBag)
        
        /********UIScrollView***********/
        self.scw.rx.contentOffset
            .subscribe(onNext: { [weak self] (point) in
                //随着contentOffset变化而变化
            })
        .disposed(by: disposeBag)
        
        /********手势***********/
        let tap = UITapGestureRecognizer()
        self.view.addGestureRecognizer(tap)
        tap.rx.event
            .subscribe(onNext: { (gesture) in
                
            })
        .disposed(by: disposeBag)
        
    }
    
    //通知
    func setupNotification() -> Void {        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { (noti) in
                
            })
            .disposed(by: disposeBag)
    }
    //Timer
    func setupTimer() -> Void {
        //不再是NSTimer
        //隔1秒，发送一个响应
        timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        timer.subscribe(onNext: { (time) in
            print(time)
            })
            .disposed(by: disposeBag)
    }
    //网络
    func setupNetwork() -> Void {
        let url = URL(string: "https:")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            print(String(data: data!, encoding: .utf8))
        }.resume()
        
        //error和其他分层了
        URLSession.shared.rx.response(request: URLRequest(url: url!))
            .subscribe(onNext: { (response,data) in
                print(response)
            }, onError: { (error) in
                print("网络失败")
            }).disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("来了")
        self.person.name = self.person.name + "+"
    }


}
