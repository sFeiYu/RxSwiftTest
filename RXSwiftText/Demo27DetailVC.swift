//
//  Demo27DetailVC.swift
//  RXSwiftText
//
//  Created by KnowChat03 on 2019/10/30.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Demo27DetailVC: UIViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - 双向绑定：<->
    func demo1() -> Void {
        
//        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
//        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)
//
//        //将用户信息绑定到label上
//        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
        
        /********************************RxSwift 自带的双向绑定操作符*******************************/
        //双向绑定操作符是：<->
//        _ =  self.textField.rx.textInput <->  self.userVM.username
//
//        //将用户信息绑定到label上
//        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
        
    }
    
    //MARK: - UIGestureRecognizer
    func demo2() -> Void {
//       //添加一个上滑手势
//       let swipe = UISwipeGestureRecognizer()
//       swipe.direction = .up
//       self.view.addGestureRecognizer(swipe)
//
//       //手势响应
//       swipe.rx.event
//           .subscribe(onNext: { [weak self] recognizer in
//               //这个点是滑动的起点
//               let point = recognizer.location(in: recognizer.view)
//               self?.showAlert(title: "向上划动", message: "\(point.x) \(point.y)")
//           })
//           .disposed(by: disposeBag)
//
//        //手势响应
//        swipe.rx.event
//            .bind { [weak self] recognizer in
//                //这个点是滑动的起点
//                let point = recognizer.location(in: recognizer.view)
//                self?.showAlert(title: "向上划动", message: "\(point.x) \(point.y)")
//            }
//            .disposed(by: disposeBag)
    }
    
    //MARK: - UIDatePicker
    
    func demo3() -> Void {
//        datePicker.rx.date
//        .map { [weak self] in
//            "当前选择时间: " + self!.dateFormatter.string(from: $0)
//        }
//        .bind(to: label.rx.text)
//        .disposed(by: disposeBag)
    }
    
    //MARK: - UITableView
    
    func demo4() -> Void {
        /********************************单个分区的表格*******************************/
            //初始化数据
//            let items = Observable.just([
//                "文本输入框的用法",
//                "开关按钮的用法",
//                "进度条的用法",
//                "文本标签的用法",
//                ])
//
//            //设置单元格数据（其实就是对 cellForRowAt 的封装）
//            items
//                .bind(to: tableView.rx.items) { (tableView, row, element) in
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//                    cell.textLabel?.text = "\(row)：\(element)"
//                    return cell
//                }
//                .disposed(by: disposeBag)
        
        /********************************单元格选中事件响应*******************************/
//        //获取选中项的索引
//        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
//            print("选中项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
//
//        //获取选中项的内容
//        tableView.rx.modelSelected(String.self).subscribe(onNext: { item in
//            print("选中项的标题为：\(item)")
//        }).disposed(by: disposeBag)
        
        /********************************单元格取消选中事件响应*******************************/
        //获取被取消选中项的索引
//        tableView.rx.itemDeselected.subscribe(onNext: { [weak self] indexPath in
//            self?.showMessage("被取消选中项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
//
//        //获取被取消选中项的内容
//        tableView.rx.modelDeselected(String.self).subscribe(onNext: {[weak self] item in
//            self?.showMessage("被取消选中项的的标题为：\(item)")
//        }).disposed(by: disposeBag)
        
        /********************************单元格移动事件响应*******************************/
        //获取移动项的索引
//        tableView.rx.itemMoved.subscribe(onNext: { [weak self]
//            sourceIndexPath, destinationIndexPath in
//            self?.showMessage("移动项原来的indexPath为：\(sourceIndexPath)")
//            self?.showMessage("移动项现在的indexPath为：\(destinationIndexPath)")
//        }).disposed(by: disposeBag)
        
        /********************************单元格插入事件响应*******************************/
        //获取插入项的索引
//        tableView.rx.itemInserted.subscribe(onNext: { [weak self] indexPath in
//            self?.showMessage("插入项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
        
        /********************************单元格尾部附件（图标）点击事件响应*******************************/
        //获取点击的尾部图标的索引
//        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { [weak self] indexPath in
//            self?.showMessage("尾部项的indexPath为：\(indexPath)")
//        }).disposed(by: disposeBag)
        
        /********************************单元格将要显示出来的事件响应*******************************/
        //获取选中项的索引
//        tableView.rx.willDisplayCell.subscribe(onNext: { cell, indexPath in
//            print("将要显示单元格indexPath为：\(indexPath)")
//            print("将要显示单元格cell为：\(cell)\n")
//
//        }).disposed(by: disposeBag)
        
        
    }
    
    //MARK: - RxDataSources
    func demo5() -> Void {
        /*
        //初始化数据
        let items = Observable.just([
            SectionModel(model: "基本控件", items: [
                "UILable的用法",
                "UIText的用法",
                "UIButton的用法"
                ]),
            SectionModel(model: "高级控件", items: [
                "UITableView的用法",
                "UICollectionViews的用法"
                ])
            ])
         
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, String>>(configureCell: {
            (dataSource, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(indexPath.row)：\(element)"
            return cell
        })
         
        //设置分区头标题
        dataSource.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].model
        }
         
        //设置分区尾标题
        //dataSource.titleForFooterInSection = { ds, index in
        //    return "footer"
        //}
         
        //绑定单元格数据
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
 */
        
        
    }
    
    func demo6() -> Void {
        
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
