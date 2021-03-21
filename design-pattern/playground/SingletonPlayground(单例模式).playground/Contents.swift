
var str = "Hello, Singleton Pattern playground"

//: ## 什么是单例模式？
//: 单例模式(Singleton Pattern)是一个比较简单的模式，其定义如下:
//:
//: Ensure a class has only one instance, and provide a global point of access to it. (确保某一个类只有一个实例，而且自行实例化并向整个系统提供这个实例)
//:
//: > 1、单例类只能有一个实例
//: > 2、单例类必须自己创建自己的唯一实例
//: > 3、单例类必须给所有其他对象提供这一实例
//:
//: ## 单例模式的几种实现方式
//:
//: 1. 懒汉式，线程不安全
//: 这种方式是最基本的实现方式，这种实现最大的问题就是不支持多线程。因为没有加锁（Java里面会用Synchronized来保证线程安全），
//: 所以严格意义上它并不算单例模式。这种方式 lazy loading 很明显，不要求线程安全，在多线程中不能正常工作。
//:
//: > 单例模式在并发量增加时则可能在内存中出现多个实例，破坏了最初的预期。如一个线程A执行 到singleton = new Singleton()，
//: > 但还没有获得对象(对象初始化是需要时间的)，第二个线程 B也在执行，执行到(singleton == null)判断，那么线程B获得判断条件也是为真，
//: > 于是继续 运行下去，线程A获得了一个对象，线程B也获得了一个对象，在内存中就出现两个对象
//:
/// 单例模式，线程不安全
class Singleton {
    private static var instance: Singleton? = nil
    
    init() {
        print("这是一个单例！")
    }
    
    static func getInstance() -> Singleton {
        if instance == nil {
            instance = Singleton()
        }
        
        return instance!
    }
}

var instance = Singleton.getInstance()

//: 2. 饿汉式，线程安全
//:
/// 单例模式，在Swift中 let 关键字是线程安全的（在Java中用Synchronized）
class Singleton1 {
    private static let instance: Singleton1 = Singleton1()
    
    init() {
        print("这是一个单例！")
    }
    
    static func getInstance() -> Singleton1 {
        return instance
    }
}

//:
//: ## 单例模式优缺点
//:
//: ### 优点
//: 1. 由于单例模式在内存中只有一个实例，减少了内存开支，特别是一个对象需要频繁地 创建、销毁时，
//: 而且创建或销毁时性能又无法优化，单例模式的优势就非常明显
//:
//: 2. 单例模式可以避免对资源的多重占用，例如一个写文件动作，由于只有一个实例存在 内存中，避免对同一个资源文件的同时写操作
//:
//: ### 缺点
//:
//: 1. 单例模式一般没有接口，扩展很困难，若要扩展，除了修改代码基本上没有第二种途径可以实现
//:
//: 2. 单例模式对测试是不利的。在并行开发环境中，如果单例模式没有完成，是不能进行测试的，没有接口也不能使用mock的方式虚拟一个对象。
//:
//: 3. 单例模式与单一职责原则有冲突。一个类应该只实现一个逻辑，而不关心它是否是单例，是不是单例取决于环境，单例模式把“要单例”和业务逻辑融合在一个类中。
//:
//: ## 单例模式的使用场景
//:
//: * 要求生成唯一序列号的环境
//:
//: * 在整个项目中需要一个共享访问点或共享数据，例如一个Web页面上的计数器，可以不用把每次刷新都记录到数据库中，使用单例模式保持计数器的值，并确保是线程安全的
//:
//: * 创建一个对象需要消耗的资源过多，如要访问IO和数据库等资源
//:
//: * 需要定义大量的静态常量和静态方法(如工具类)的环境，可以采用单例模式(也可以直接声明为static的方式)
