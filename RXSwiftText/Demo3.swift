//
//  Demo3.swift
//  RXSwiftText
//
//  Created by 钱飞英 on 2019/10/20.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo3: ViewController {
    
    let txfUserName = UITextField()
    let txfPassword = UITextField()
    let lblUserName = UILabel()
    let btnLogin = UIButton(type: .custom)
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //txfUserName.rx.text序列usernameVaild
        //多个都需要绑定时，可以定义一个变量
        let usernameVaild = txfUserName.rx.text.orEmpty
            .map { (text) -> Bool in
                return text.count >= 5
        }
        //绑定到我们验证显示
        usernameVaild.bind(to: lblUserName.rx.isHidden).disposed(by: disposeBag)
        usernameVaild.bind(to: txfPassword.rx.isEnabled).disposed(by: disposeBag)
        
        let passwordVaild = txfPassword.rx.text.orEmpty
            .map { (text) -> Bool in
                return text.count >= 9
        }
        passwordVaild.bind(to: txfPassword.rx.isHidden).disposed(by: disposeBag)
        
        
        //决定按钮----btnLogin
        Observable.combineLatest(usernameVaild, passwordVaild){
            $0&&$1
            }.bind(to: btnLogin.rx.isUserInteractionEnabled).disposed(by: disposeBag)
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
