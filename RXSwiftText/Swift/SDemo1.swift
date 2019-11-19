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
        
        //可以用元组作为返回值
        sumData(a: 1, b: 2)
    }
    
    //以下这种形式用于函数注释，按住option可以查看
    /// 求和函数【概述】
    ///
    /// 将2个整数相加【更详细的描述】
    /// - Parameter a: 数值1
    /// - Parameter b: 数值2
    /// - Returns : 2个整数的和
    /// - Note : 传入2个整数即可【批注】
    
    func sumData(a:Int,b:Int) -> Void {
        a + b
    }
    
    var number = 10
    //MARK: 参数
    func sum(_ numbers:Int..., str:String) -> Void {
        //一个函数只能有1个可变参数
        //可变参数后面的参数，不能省略标签参数
        add(&number)//只能调用写&
        
        //标签参数为_时，调用时会发现，参数名字不显示
    }
    
    
    func add(_ num: inout Int) -> Void {
        num += 1 //必须加inout 和 &
        
        //inout传递的本质是地址传递（引用传递）
        //只能传入被多次赋值的数，比如变量
        //如果传递给inout参数的是计算属性，有监听器的属性等内容（其本质就不是引用传递）
    }
    
    /********************************函数重载*******************************/
    //函数名相同
    //参数不同||参数类型不同||参数标签不同
    //返回值类型无重载无关
    
    /********************************内联函数*******************************/
    //优化速度，将函数打开了，直接调用里面的语句（内部语句比较少的时候）
    //需要xcode去开启，build setting -> 输入optimization
    
     // 永远不会被内联(即使开启了编译器优化)
//    @inline(never) func test() {
//        print("test")
//    }
     // 开启编译器优化后，即使代码很长，也会被内联(递归调用函数、动态派发的函数除外)
//    @inline(__always) func test() {
//        print("test")
//    }
    
    //在Release模式下，编译器已经开启优化，会自动决定哪些函数需要内联，因此没必要使用@inline
    
    
}


struct 枚举 {
    
    /********************************定义*******************************/
//    enum Direction {
//        case north
//        case south
//        case east
//        case west
//    }

    //enum Direction {
    //    case north,south,east,west
    //}
    //以上2者完全相同
    
    /********************************关联值*******************************/
    //有时将枚举的成员值跟其他类型的值关联存储在一起，会非常有用
     
    enum Score {
        case points(Int)
        case garde(Character)
    }

    func score()  {
        var score = Score.points(97)
        score = Score.garde("A")
            
        switch score {
        case let .points(i):
            print(i, "points")
        case let .garde(i):
            print("grade", i)
        }
        
        
    }
    
    /********************************原始值*******************************/
    // 枚举成员可以使用相同类型的默认值预先对应，这个默认值叫做:原始值

//    enum Grade : String {
//        case perfect = "A"
//        case great = "B"
//        case good = "C"
//        case bad = "D"
//    }
//    print(Grade.perfect.rawValue)
    //注意:原始值不占用枚举变量的内存
    
    //如果枚举的原始值类型是Int,String,Swift会自动分配原始值（隐式原始值）(Int:0,1...； String:变量名)
    
    /********************************递归枚举*******************************/
    //前面要加indirect
   indirect  enum Arithexpr {
        case number(Int)
        case sum(Arithexpr,Arithexpr)
    }
    
    /********************************MemoryLayout*******************************/
    //获取数据类型占用的内存
    //MemoryLayout<Int>.size
    
    func demo1() -> Void {
//        print(Mems.prt())  //封装的查看内存的工具
    }
    
    //一般的枚举只占1个字节
    //初始值的枚举也占1个字节
    //关联值占:1(代表枚举类型)+n(n:表示占用内存最大的关联值)
    /*
    // 1个字节存储成员值
    // N个字节存储关联值（N取占用内存最大的关联值），任何一个case的关联值都共用这N个字节
    // 共用体
     */
    enum TestEnum {
        case test1(Int, Int, Int)
        case test2(Int, Int)
        case test3(Int)
        case test4(Bool)
        case test5
    }
    //有30个最大的字节，使用了25个（1+24， 1表示的是test1,test2..., 24表示后面的值）
    // 小端：高高低低
    // 01 00 00 00 00 00 00 00
    // 02 00 00 00 00 00 00 00
    // 03 00 00 00 00 00 00 00
    // 00
    // 00 00 00 00 00 00 00
//    var e = TestEnum.test1(1, 2, 3)
//    print(Mems.ptr(ofVal: &e))
    
    // 04 00 00 00 00 00 00 00
    // 05 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 01
    // 00 00 00 00 00 00 00
//    e = .test2(4, 5)
//    print(Mems.memStr(ofVal: &e))
    
    // 06 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 02
    // 00 00 00 00 00 00 00
//    e = .test3(6)
    
    // 01 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 03
    // 00 00 00 00 00 00 00
//    e = .test4(true)
    
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 00 00 00 00 00 00 00 00
    // 04
    // 00 00 00 00 00 00 00
//    e = .test5
    
    enum TestEnum1 {
        case test
    }
    //使用内存是0
    //分配内存1
    //因为不需要区分是哪个枚举，只有一个类型
    //    print(MemoryLayout<Point>.size)   0
    //    print(MemoryLayout<Point>.stride) 1
    //    print(MemoryLayout<Point>.alignment) 1
}

struct 可选项 {
    //可选项，后面必须加？
    
    /********************************可选项绑定*******************************/
    func demo1() -> Void {
        if let number = Int("123") {
            print("\(number)")
        }else{
            print("失败")
        }
    }
    
    /********************************空合并运算符*******************************/
    //a ?? b
    
    //字典取出来是可选类型，数组不是
    
    /********************************guard*******************************/
    //一定要跳出循环。return,break。。。。
    //作用域在一个函数内
    
    /********************************隐式解包*******************************/
//    let num1: Int! = 10
//    let num2: Int = num1
    
    //这种写法num1可以为nil
    //不太建议使用
    
    /********************************多重可选项*******************************/
    //help frame  //查看frame的指令有哪些
    //可以使用lldb指令 frame variable -R 或者 fr v -R查看区别
    //fr v -R num1
    
   // num1 == num3 //false
    
    
    
}

struct 汇编 {
    
    //1.rax,rbx常作为函数返回值使用
    //2.rdi,rsi,rdx,rcx,r8,r9等寄存器常用于存放函数参数
    //3.rsp,rbp用于栈操作
    //4.rip作为指令指针:存储着CPU下一条要执行的指令的地址，一旦CPU读取一条指令，rip会自动指向下一条指令（存储下一条指令的地址）
    
    
//    mov + q(操作数长度)
//    movq : 把值赋值给
//    leaq : 把地址给
//    jmp : 跳转地址，间接跳转
//    callq : 跳转（函数地址）与 retq 配合使用（回转回来）
//    movl :
//    ()里面放的是内存地址
    
//    0x4bdx(%rip)  全局变量，全局区（数据段）
//    -0x78(%rbp) 局部变量，栈空间
//    0x10(%rax)  堆空间
    
//    10:立即数:都加个$
}

struct 结构体_类 {
    
    //结构体是值类型，类是引用类型
    //初始化器，保证所有的成员都有初始值，即使是nil
    
    func demo1() -> Void {
        
    }
    
    var x:Int = 0
    var y:Int = 0
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /********************************类*******************************/
    //不会自动生成可以传入成员值的初始化器
    
    //alloc,malloc 是堆空间
    
    /********************************值类型*******************************/
    //深拷贝
    
//    rax是地址，堆空间
//    rip是全局变量，全局区（数据段）
//    rbp是局部变量，栈空间
    
    /*
     补充：
     page15:
     1.malloc分配的大小为48(16的倍数，malloc)
     p19:
     1.类里面和外面的函数，内存没区别，都在代码段
     
     */
    
}

struct 闭包 {
    /*
    补充：
     p7:
     1.leaq:找房间号（地址），movq:找房间里的人（内容）
     2.num放在堆空间
     3.每调用getFn就会分配一次堆空间
     4.栈空间在一起的，地址是连续的，堆空间不连续
     */
    
    func way() -> Void {
        var nums = [1,4,2,7]
        nums.sort{ $1 < $2 }
    }
    
    

}


struct 属性 {
    //p2:结构体占8个字节
    //计算属性本质上是方法
    
    //p4:不能单独有set方法
    
    //p5:枚举的rawvalue是个计算属性，只有一个get方法(只读计算属性，不占用内存)
    
//    p6:针对比较重的属性，比较耗时，用lazy

}


struct 继承 {
//    p5:父类是calss修饰，子类可以用static修饰
//    p6:只能重写为计算属性
}

