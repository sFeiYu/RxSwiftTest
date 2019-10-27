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
    
    //带间隔的区间值
    func demo2() -> Void {
        let hours = 11
        let hourInterval = 2
        //tickMark的取值：从4开始，累加2，不超过11
        for tickMark in stride(from: 4, through: hours, by: hourInterval) {
            print(tickMark)
        }
    }

}
