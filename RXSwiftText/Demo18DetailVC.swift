//
//  Demo18DetailVC.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/28.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo18DetailVC: UIViewController {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Driver
    //Driver 可以说是最复杂的 trait，它的目标是提供一种简便的方式在 UI 层编写响应式代码。
    func demo1() -> Void {
        /********************************Driver*******************************/
        /*
        如果我们的序列满足如下特征，就可以使用它：

        不会产生 error 事件
        一定在主线程监听（MainScheduler）
        共享状态变化（shareReplayLatestWhileConnected）
         */
        
    }
    
    //MARK: - 特征序列3：ControlProperty、 ControlEvent
    
    func demo2() -> Void {
        /********************************ControlProperty*******************************/
        
        /*
        （1）ControlProperty 是专门用来描述 UI 控件属性，拥有该类型的属性都是被观察者（Observable）。

        （2）ControlProperty 具有以下特征：

        不会产生 error 事件
        一定在 MainScheduler 订阅（主线程订阅）
        一定在 MainScheduler 监听（主线程监听）
        共享状态变化

        */
        //其实在 RxCocoa 下许多 UI 控件属性都是被观察者（可观察序列）
        
        /********************************ControlEvent*******************************/
        //ControlEvent 是专门用于描述 UI 所产生的事件，拥有该类型的属性都是被观察者（Observable）。
        /**
         ControlEvent 和 ControlProperty 一样，都具有以下特征：

         不会产生 error 事件
         一定在 MainScheduler 订阅（主线程订阅）
         一定在 MainScheduler 监听（主线程监听）
         共享状态变化

        
         */
    }
    
    //MARK: - 调度器、subscribeOn、observeOn
    func demo3() -> Void {
        /********************************调度器Schedulers*******************************/
        //调度器（Schedulers）是 RxSwift 实现多线程的核心模块，它主要用于控制任务在哪个线程或队列运行。
        /*
         CurrentThreadScheduler：表示当前线程 Scheduler。（默认使用这个）
         MainScheduler：表示主线程。如果我们需要执行一些和 UI 相关的任务，就需要切换到该 Scheduler运行。
         SerialDispatchQueueScheduler：封装了 GCD 的串行队列。如果我们需要执行一些串行任务，可以切换到这个 Scheduler 运行。
         ConcurrentDispatchQueueScheduler：封装了 GCD 的并行队列。如果我们需要执行一些并发任务，可以切换到这个 Scheduler 运行。
         OperationQueueScheduler：封装了 NSOperationQueue。

         */
        
//        let rxData: Observable<Data> = ...
//        rxData
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)) //后台构建序列
//            .observeOn(MainScheduler.instance)  //主线程监听并处理序列结果
//            .subscribe(onNext: { [weak self] data in
//                self?.data = data
//            })
//            .disposed(by: disposeBag)
        
        /********************************subscribeOn 与 observeOn 区别*******************************/
        /*
         subscribeOn
         该方法决定数据序列的构建函数在哪个 Scheduler 上运行。
         比如上面样例，由于获取数据、解析数据需要花费一段时间的时间，所以通过 subscribeOn 将其切换到后台 Scheduler 来执行。这样可以避免主线程被阻塞。
         */
        
        /*
         该方法决定在哪个 Scheduler 上监听这个数据序列。
         比如上面样例，我们获取并解析完毕数据后又通过 observeOn 方法切换到主线程来监听并且处理结果。
        */
    }
    
    //MARK: - UI控件扩展1：
    func demo4() -> Void {
        
        /********************************UILabel*******************************/
//        let label = UILabel(frame: CGRect(x: 20, y: 40, width: 300, height: 100))
//        self.view.addSubview(label)
//
//        let timer = Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
//        timer.map { String(format: "%0.2d:%0.2d.%0.1d", [($0 / 600) % 600, ($0 % 600 ) / 10, $0 % 10]) }
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
        /********************************UITextField 与 UITextView*******************************/
        
//        let textField = UITextField()
//        self.view.addSubview(textField)
//        textField.rx.text.orEmpty.asObservable()
//            .subscribe(onNext: { (str) in
//                print("您输入的是：\(str)")
//            }).disposed(by: disposeBag)
        
        /********************************Throttling*******************************/
        /*
         Throttling 是 RxSwift 的一个特性。因为有时当一些东西改变时，通常会做大量的逻辑操作。而使用 Throttling 特性，不会产生大量的逻辑操作，而是以一个小的合理的幅度去执行。比如做一些实时搜索功能时，这个特性很有用。
         */
        //创建文本输入框
        let inputField = UITextField(frame: CGRect(x:10, y:80, width:200, height:30))
        inputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(inputField)
         
        //创建文本输出框
        let outputField = UITextField(frame: CGRect(x:10, y:150, width:200, height:30))
        outputField.borderStyle = UITextField.BorderStyle.roundedRect
        self.view.addSubview(outputField)
         
        //创建文本标签
        let label = UILabel(frame:CGRect(x:20, y:190, width:300, height:30))
        self.view.addSubview(label)
         
        //创建按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:20, y:230, width:40, height:30)
        button.setTitle("提交", for:.normal)
        self.view.addSubview(button)
        
        let input = inputField.rx.text.orEmpty.asDriver()// 将普通序列转换为 Driver
            .throttle(0.3)//在主线程中操作，0.3秒内值若多次改变，取最后一次
        
        input.drive(outputField.rx.text)
        .disposed(by: disposeBag)
        
        input.map{"当前字数：\($0.count)"}
            .drive(label.rx.text)
        .disposed(by: disposeBag)
        
        input.map{$0.count > 5}
            .drive(button.rx.isEnabled)
        .disposed(by: disposeBag)
        
        /********************************同时监听多个 textField 内容的变化（textView 同理）*******************************/
      
        Observable.combineLatest(inputField.rx.text.orEmpty, outputField.rx.text.orEmpty) {
            textValue1, textValue2 -> String in
            return "你输入的号码是：\(textValue1)-\(textValue2)"
        }.map{$0}
            .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        /********************************事件监听*******************************/
        /*
         editingDidBegin：开始编辑（开始输入内容）
         editingChanged：输入内容发生改变
         editingDidEnd：结束编辑
         editingDidEndOnExit：按下 return 键结束编辑
         allEditingEvents：包含前面的所有编辑相关事件
         */
        
        inputField.rx.controlEvent(.editingDidEnd)
        .asObservable()
            .subscribe(onNext: { (_) in
                
            })
        .disposed(by: disposeBag)
        
        /********************************UITextView 独有的方法*******************************/
        /*
         didBeginEditing：开始编辑
         didEndEditing：结束编辑
         didChange：编辑内容发生改变
         didChangeSelection：选中部分发生变化
         */
        
    }
    
    //MARK: - UI控件UIButton
    func demo5() -> Void {
        /********************************UIButton 与 UIBarButtonItem*******************************/
        let button = UIButton()
        
        //按钮点击响应
//        button.rx.tap
//            .bind { [weak self] in
//                self?.showMessage("按钮被点击")
//            }
//            .disposed(by: disposeBag)
        
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        timer.map{"计数\($0)"}
            .bind(to: button.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
//        timer.map(formatTimeInterval) //formatTimeInterval是一个方法
//        .bind(to: button.rx.attributedTitle())
//        .disposed(by: disposeBag)
        
        //多个按钮置允许点一个
        /*
        //强制解包，避免后面还需要处理可选类型
        let buttons = [button1, button2, button3].map { $0! }
         
        //创建一个可观察序列，它可以发送最后一次点击的按钮（也就是我们需要选中的按钮）
        let selectedButton = Observable.from(
            buttons.map { button in button.rx.tap.map { button } }
            ).merge()
         
        //对于每一个按钮都对selectedButton进行订阅，根据它是否是当前选中的按钮绑定isSelected属性
        for button in buttons {
            selectedButton.map { $0 == button }
                .bind(to: button.rx.isSelected)
                .disposed(by: disposeBag)
        }
 */
        
        /********************************UISwitch 与 UISegmentedControl*******************************/
//        switch1.rx.isOn.asObservable()
//        .subscribe(onNext: {
//            print("当前开关状态：\($0)")
//        })
//        .disposed(by: disposeBag)
        
//        segmented.rx.selectedSegmentIndex.asObservable()
//        .subscribe(onNext: {
//            print("当前项：\($0)")
//        })
//        .disposed(by: disposeBag)
        
        /********************************UIActivityIndicatorView 与 UIApplication*******************************/
        
        /********************************UISlider、UIStepper*******************************/
//        slider.rx.value.asObservable()
//                   .subscribe(onNext: {
//                       print("当前值为：\($0)")
//                   })
//                   .disposed(by: disposeBag)
        
//        stepper.rx.value.asObservable()
//        .subscribe(onNext: {
//            print("当前值为：\($0)")
//        })
//        .disposed(by: disposeBag)
    }
    
    
    
    


}
