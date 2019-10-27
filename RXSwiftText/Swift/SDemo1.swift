//
//  SDemo1.swift
//  RXSwiftText
//
//  Created by 钱飞英 on 2019/10/27.
//  Copyright © 2019 钱飞英. All rights reserved.
//

import UIKit

class SDemo1: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        demo1()
    }
    
    func demo1() -> Void {
        let range1:ClosedRange<Int> = 1...3
        let range2:Range<Int> = 1..<3
        
        let stringRange1 = "cc"..."ff"
        stringRange1.contains("cb") //false
        stringRange1.contains("dz") //true
        
        //字符类型必须声明
        let a:Character = "a"
        
    }
    
    //MARK: 带间隔的区间值
    func demo2() -> Void {
        let hours = 11
        let hourInterval = 2
        //tickMark的取值：从4开始，累加2，不超过11
        for tickMark in stride(from: 4, through: hours, by: hourInterval) {
            print(tickMark)
        }
    }
    
    //MARK:swicth
    func demo3() -> Void {
        //要想贯穿用fallthrough
        //默认不加break也不会贯穿
        
        //switch 必须保证能处理所有情况，可以加个default
        //case、default后面必须加一条语句，比如break
        //switch支持String, Character类型，元组类型
        
        //值绑定
        let point = (2, 0)
        switch point {
        case (let x, 0):
            print(x);
        default:
            print("default")
        }
        
        //where
        let point1 = (1, -1)
        switch point1 {
        case let (x, y) where x == y:
            print("x==y");
        default:
            print("default")
        }
        
        //where还可以放在for循环里面
        for i in -1...3 where i  > 0 {
            //作用相当于contiun
            print(i)
        }
    }
    
    //MARK:标签语句
    func demo4() -> Void {
        outer:for i in 0...3 {
            for j in 0...3 {
                if i == 3{
                    //结束外层此次循环
                    continue outer
                }
                
            }
        }
    }
    
    //MARK:函数
    func demo5() -> Void {
        //形式参数是let,只能是let
    }
    
    

}
