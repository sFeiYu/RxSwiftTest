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

class Demo1VC: UIViewController {
    
    var person = NewPerson()
    let disposeBag = DisposeBag()
    let btn = UIButton(type: .custom)
    let txf = UITextField()
    
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
//        self.btn.rx.tap
//            .subscribe(onNext: { ()in
//
//            }).disposed(by: disposeBag)
        
        self.btn.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { () in
                
            }).disposed(by: disposeBag)
        
        self.txf.
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("来了")
        self.person.name = self.person.name + "+"
    }


}
