//
//  Demo4.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/21.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo4: UIViewController {

    let disposebag = DisposeBag()
//    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //定时器1：
//        timer = Timer(timeInterval: 1, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
//        RunLoop.current.add(timer, forMode: .default)
        
        //定时器2：
        //不受runloop影响
//       let gcdTimer =  DispatchSource.makeTimerSource()
//        gcdTimer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(1))
//        gcdTimer.setEventHandler {
//            print("gcdTimer=====")
//        }
//        gcdTimer.resume()
        
        //定时器3：
//        let cadTimer = CADisplayLink(target: self, selector: #selector(timerEvent))
//        if #available(iOS 10.0, *) {
//            cadTimer.preferredFramesPerSecond = 1
//        }
//        cadTimer.add(to: RunLoop.current, forMode: .default)
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        timer.subscribe(onNext: { (interval) in
            
        }).disposed(by: disposebag)
       //终止可以重新定义disposebag：disposebag = DisposeBag()，这样，以前的垃圾袋中的东西会全部被销毁
        
        
        
    }
    
    @objc func timerEvent() -> Void {
        
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
