# Multithread 多线程

----

50个多线程面试题

   https://blog.csdn.net/cmyperson/article/details/79610870

多线程面试题    

   https://blog.csdn.net/tanmomo/article/details/99671622

多线程模拟售票，多个窗口售票

   https://www.cnblogs.com/majingang/p/9055669.html


##并发编程三要素？
    1）原子性

    原子性指的是一个或者多个操作，要么全部执行并且在执行的过程中不被其他操作打断，要么就全部都不执行。

    2）可见性

    可见性指多个线程操作一个共享变量时，其中一个线程对变量进行修改后，其他线程可以立即看到修改的结果。

    3）有序性

    有序性，即程序的执行顺序按照代码的先后顺序来执行。



##创建线程的三种方式的对比？
    1）采用实现Runnable、Callable接口的方式创建多线程。

    优势是：

        线程类只是实现了Runnable接口或Callable接口，还可以继承其他类。

        在这种方式下，多个线程可以共享同一个target对象，所以非常适合多个相同线程来处理同一份资源的情况，从而可以将CPU、代码和数据分开，形成清晰的模型，较好地体现了面向对象的思想。

    劣势是：

        编程稍微复杂，如果要访问当前线程，则必须使用Thread.currentThread()方法。


    2）使用继承Thread类的方式创建多线程

    优势是：

        编写简单，如果需要访问当前线程，则无需使用Thread.currentThread()方法，直接使用this即可获得当前线程。

    劣势是：

        线程类已经继承了Thread类，所以不能再继承其他父类。

    3）Runnable和Callable的区别

        Callable规定（重写）的方法是call()，Runnable规定（重写）的方法是run()。
        Callable的任务执行后可返回值，而Runnable的任务是不能返回值的。
        Call方法可以抛出异常，run方法不可以。
        运行Callable任务可以拿到一个Future对象，表示异步计算的结果。它提供了检查计算是否完成的方法，以等待计算的完成，并检索计算的结果。通过Future对象可以了解任务执行情况，可取消任务的执行，还可获取执行结果。


##线程池的优点？

    1）重用存在的线程，减少对象创建销毁的开销。

    2）可有效的控制最大并发线程数，提高系统资源的使用率，同时避免过多资源竞争，避免堵塞。

    3）提供定时执行、定期执行、单线程、并发数控制等功能。

##Java锁的种类
    乐观锁/悲观锁
    独享锁/共享锁
    互斥锁/读写锁
    可重入锁
    公平锁/非公平锁
    分段锁
    偏向锁/轻量级锁/重量级锁
    自旋锁

##什么是乐观锁和悲观锁

    1）乐观锁：就像它的名字一样，对于并发间操作产生的线程安全问题持乐观状态，乐观锁认为竞争不总是会发生，
        因此它不需要持有锁，将比较-替换这两个动作作为一个原子操作尝试去修改内存中的变量，如果失败则表示发生冲突，那么就应该有相应的重试逻辑。

    2）悲观锁：还是像它的名字一样，对于并发间操作产生的线程安全问题持悲观状态，悲观锁认为竞争总是会发生，
        因此每次对某资源进行操作时，都会持有一个独占的锁，就像synchronized，不管三七二十一，直接上了锁就操作资源了。

    
    
    悲观锁适合写操作非常多的场景，乐观锁适合读操作非常多的场景，不加锁会带来大量的性能提升。

    悲观锁在Java中的使用，就是利用各种锁。

    乐观锁在Java中的使用，是无锁编程，常常采用的是CAS算法，典型的例子就是原子类，通过CAS自旋实现原子操作的更新


##独享锁/共享锁

    独享锁是指该锁一次只能被一个线程所持有。

    共享锁是指该锁可被多个线程所持有。

    对于Java ReentrantLock而言，其是独享锁。但是对于Lock的另一个实现类ReadWriteLock，其读锁是共享锁，其写锁是独享锁。

    读锁的共享锁可保证并发读是非常高效的，读写，写读，写写的过程是互斥的。

    独享锁与共享锁也是通过AQS来实现的，通过实现不同的方法，来实现独享或者共享。

    对于Synchronized而言，当然是独享锁。



##互斥锁/读写锁

    上面讲的独享锁/共享锁就是一种广义的说法，互斥锁/读写锁就是具体的实现。

    互斥锁在Java中的具体实现就是ReentrantLock。

    读写锁在Java中的具体实现就是ReadWriteLock。

##Java通过Executors提供四种线程池，分别为：

    newCachedThreadPool创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。

    newFixedThreadPool 创建一个定长线程池，可控制线程最大并发数，超出的线程会在队列中等待。

    newScheduledThreadPool 创建一个定长线程池，支持定时及周期性任务执行。

    newSingleThreadExecutor 创建一个单线程化的线程池，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。  



##JDK 7 提供了7个阻塞队列，如下

    1、ArrayBlockingQueue 数组结构组成的有界阻塞队列。

    此队列按照先进先出（FIFO）的原则对元素进行排序，但是默认情况下不保证线程公平的访问队列，即如果队列满了，那么被阻塞在外面的线程对队列访问的顺序是不能保证线程公平（即先阻塞，先插入）的。

    2、LinkedBlockingQueue一个由链表结构组成的有界阻塞队列

    此队列按照先出先进的原则对元素进行排序

    3、PriorityBlockingQueue支持优先级的无界阻塞队列

    4、DelayQueue支持延时获取元素的无界阻塞队列，即可以指定多久才能从队列中获取当前元素

    5、SynchronousQueue不存储元素的阻塞队列，每一个put必须等待一个take操作，否则不能继续添加元素。并且他支持公平访问队列。

    6、LinkedTransferQueue由链表结构组成的无界阻塞TransferQueue队列。相对于其他阻塞队列，多了tryTransfer和transfer方法

        transfer方法

        如果当前有消费者正在等待接收元素（take或者待时间限制的poll方法），transfer可以把生产者传入的元素立刻传给消费者。如果没有消费者等待接收元素，则将元素放在队列的tail节点，并等到该元素被消费者消费了才返回。

        tryTransfer方法

        用来试探生产者传入的元素能否直接传给消费者。，如果没有消费者在等待，则返回false。和上述方法的区别是该方法无论消费者是否接收，方法立即返回。而transfer方法是必须等到消费者消费了才返回。

    7、LinkedBlockingDeque链表结构的双向阻塞队列，优势在于多线程入队时，减少一半的竞争


##synchronized 关键字
    synchronized关键字可以保证被它修饰的方法或者代码块在任意时刻只能有一个线程执行。

##synchronized关键字最主要的三种使用方式：
    修饰实例方法:、修饰静态方法、修饰代码块。

    对于普通同步方法，锁是当前实例对象。
    对于静态同步方法，锁是当前类的Class对象。
    对于同步代码块，锁是synchronized括号里配置的对象。
    　　当一个线程试图访问同步代码块时，它首先必须得到锁，退出或抛出异常时必须释放锁。

##synchronized在JVM里是怎么实现的？
    
    　　synchronized 同步语句块的实现使用的是 monitorenter 和 monitorexit 指令，其中 monitorenter 指令指向同步代码块的开始位置，
    monitorexit 指令则指明同步代码块的结束位置。 当执行 monitorenter 指令时，线程试图获取锁也就是获取 monitor的持有权。
    当计数器为0则可以成功获取，获取后将锁计数器设为1也就是加1。相应的在执行 monitorexit 指令后，将锁计数器设为0，表明锁被释放。
    如果获取对象锁失败，那当前线程就要阻塞等待，直到锁被另外一个线程释放为止。
    
    (monitor对象存在于每个Java对象的对象头中，synchronized 锁便是通过这种方式获取锁的，也是为什么Java中任意对象可以作为锁的原因) 

##synchronized用的锁是存在哪里的？
    synchronized用到的锁是存在Java对象头里的。
    
##JDK1.6 之后的synchronized 关键字底层做了哪些优化，可以详细介绍一下这些优化吗

    JDK1.6 对锁的实现引入了大量的优化，如偏向锁、轻量级锁、自旋锁、适应性自旋锁、锁消除、锁粗化等技术来减少锁操作的开销。

    锁主要存在四种状态，
    依次是：无锁状态、偏向锁状态、轻量级锁状态、重量级锁状态，他们会随着竞争的激烈而逐渐升级。
    
    注意锁可以升级不可降级，这种策略是为了提高获得锁和释放锁的效率。

    关于这几种优化的详细信息可以查看这篇文章：
    https://gitee.com/SnailClimb/JavaGuide/blob/master/docs/java/Multithread/synchronized.md



##synchronized和 Lock 的区别？（重要）
    1）Lock是一个接口，而synchronized是Java中的关键字，synchronized是内置的语言实现；

    2）synchronized在发生异常时，会自动释放线程占有的锁，因此不会导致死锁现象发生；
    而Lock在发生异常时，如果没有主动通过unLock()去释放锁，则很可能造成死锁现象，因此使用Lock时需要在finally块中释放锁；

    3）Lock可以让等待锁的线程响应中断，而synchronized却不行，使用synchronized时，等待的线程会一直等待下去，不能够响应中断；

    4）通过Lock可以知道有没有成功获取锁（tryLock()方法：如果获取锁成功，则返回true），而synchronized却无法办到。

    5）Lock可以提高多个线程进行读操作的效率。

    　　在性能上来说，如果竞争资源不激烈，两者的性能是差不多的，而当竞争资源非常激烈时（即有大量线程同时竞争），
    此时Lock的性能要远远优于synchronized。所以说，在具体使用时要根据适当情况选择。

    参考https://blog.csdn.net/qq_38200548/article/details/82943222     


##synchronized和ReentrantLock（重入锁） 的区别？
    两者都是可重进入锁，就是能够支持一个线程对资源的重复加锁。sychnronized关键字隐式的支持重进入，比如一个sychnronized修饰的递归方法，
    在方法执行时，执行线程在获取了锁之后仍能连续多次地获取该锁。ReentrantLock虽然没能像sychnronized关键字一样隐式的重进入，
    但是在调用lock()方法时，已经获取到锁的线程，能够再次调用lock()方法获取锁而不被阻塞。
    线程重复n次获取了锁，随后在第n次释放该锁后，其他线程能够获取到该锁。锁的最终释放要求锁对于获取进行计数自增，计数表示当前锁被重复获取的次数，
    而锁被释放时，计数自减，当计数等于0时表示锁已经成功被释放。
    synchronized 依赖于 JVM 而 ReentrantLock 依赖于 API。ReentrantLock 是 JDK 层面实现的（也就是 API 层面，
    需要 lock() 和 unlock() 方法配合 try/finally 语句块来完成）
    ReentrantLock 比 synchronized 增加了一些高级功能，主要有3点：
        ①等待可中断；②可实现公平锁；③可实现选择性通知（锁可以绑定多个条件）
    ReentrantLock提供了一种能够中断等待锁的线程的机制，也就是说正在等待的线程可以选择放弃等待，改为处理其他事情。通过lock.lockInterruptibly()来实现这个机制。
    ReentrantLock可以指定是公平锁还是非公平锁。而synchronized只能是非公平锁。（公平锁就是先等待的线程先获得锁）
    synchronized关键字与wait()和notify()/notifyAll()方法相结合可以实现等待/通知机制。ReentrantLock类当然也可以实现，
        但是需要借助于Condition接口与newCondition() 方法。用ReentrantLock类结合Condition实例可以实现“选择性通知” 。
        如果执行notifyAll()方法的话就会通知所有处于等待状态的线程这样会造成很大的效率问题，
        而Condition实例的signalAll()方法 只会唤醒注册在该Condition实例中的所有等待线程    
        

##volatile关键字
    保证共享变量的“可见性”。可见性的意思是当一个线程修改一个共享变量时，另外一个线程能读到这个修改的值。
    把变量声明为volatile，这就指示 JVM每次使用它都到主存中进行读取     

##synchronized 关键字和 volatile 关键字的区别
    volatile关键字是线程同步的轻量级实现，所以volatile性能比synchronized关键字要好。但是volatile关键字只能用于变量而synchronized关键字可以修饰方法以及代码块。
    多线程访问volatile关键字不会发生阻塞，而synchronized关键字可能会发生阻塞。、
    volatile关键字主要用于解决变量在多个线程之间的可见性，而 synchronized关键字解决的是多个线程之间访问资源的同步性。
    volatile关键字能保证数据的可见性，但不能保证数据的原子性。synchronized关键字两者都能保证   
    
##使用线程池的好处？
    降低资源消耗。通过重复利用已创建的线程，降低线程创建和销毁造成的消耗。
    提高响应速度。当任务到达时，任务可以不需要等到线程创建就能立即执行。
    提高线程的可管理性。线程是稀缺资源，如果无限制地创建，不仅会消耗系统资源，还会降低系统的稳定性，使用线程池可以进行统一分配、调优和监控



##创建线程的几种方式？（重要）
    有4种方式：继承Thread类、实现Runnable接口、实现Callable接口、使用Executor框架来创建线程池
    
    通过继承Thread类创建线程
    
    通过实现Runnable接口来创建线程
    
    实现Callable接口来创建线程
    　　与实现Runnable接口类似，和Runnable接口不同的是，Callable接口提供了一个call() 方法作为线程执行体，call()方法比run()方法功能要强大：
        call()方法可以有返回值、call()方法可以声明抛出异常。

    使用Executor框架来创建线程池
    　　Executors.newXXXX： newFixedThreadPool(int )、newSingleThreadExecutor、newCachedThreadPool、newScheduledThreadPool(int)
     　　通过Executors的以上四个静态工厂方法获得 ExecutorService实例，而后可以执行Runnable任务或Callable任务。


###实现Runnable接口和Callable接口的区别？
         Runnable接口或Callable接口实现类都可以被ThreadPoolExecutor或ScheduledThreadPoolExecutor执行。两者的区别在于 Runnable 接口不会返回结果但是 Callable 接口可以返回结果。

        执行execute()方法和submit()方法的区别是什么呢？
        1) execute() 方法用于提交不需要返回值的任务，所以无法判断任务是否被线程池执行成功与否；

        2) submit() 方法用于提交需要返回值的任务。线程池会返回一个Future类型的对象，通过这个Future对象可以判断任务是否执行成功，并且可以通过future的get()方法来获取返回值
        
        
    
    
    

##1.什么是活锁、饥饿、无锁、死锁？

    死锁、活锁、饥饿是关于多线程是否活跃出现的运行阻塞障碍问题，如果线程出现 了这三种情况，即线程不再活跃，不能再正常地执行下去了。

    死锁

        死锁是多线程中最差的一种情况，多个线程相互占用对方的资源的锁，而又相互等 对方释放锁，此时若无外力干预，这些线程则一直处理阻塞的假死状态，形成死锁。

         举个例子，A 同学抢了 B 同学的钢笔，B 同学抢了 A 同学的书，两个人都相互占 用对方的东西，都在让对方先还给自己自己再还，这样一直争执下去等待对方还而 又得不到解决，

        老师知道此事后就让他们相互还给对方，这样在外力的干预下他们 才解决，当然这只是个例子没有老师他们也能很好解决，计算机不像人如果发现这 种情况没有外力干预还是会一直阻塞下去的。

    活锁

        活锁这个概念大家应该很少有人听说或理解它的概念，而在多线程中这确实存在。

         活锁恰恰与死锁相反，死锁是大家都拿不到资源都占用着对方的资源，而活锁是拿 到资源却又相互释放不执行。

        当多线程中出现了相互谦让，都主动将资源释放给别 的线程使用，这样这个资源在多个线程之间跳动而又得不到执行，这就是活锁。

    饥饿

        我们知道多线程执行中有线程优先级这个东西，优先级高的线程能够插队并优先执 行，这样如果优先级高的线程一直抢占优先级低线程的资源，导致低优先级线程无 法得到执行，这就是饥饿。

        当然还有一种饥饿的情况，一个线程一直占着一个资源 不放而导致其他线程得不到执行，与死锁不同的是饥饿在以后一段时间内还是能够 得到执行的，如那个占用资源的线程结束了并释放了资源。

    无锁

        无锁，即没有对资源进行锁定，即所有的线程都能访问并修改同一个资源，但同时 只有一个线程能修改成功。

        无锁典型的特点就是一个修改操作在一个循环内进行， 线程会不断的尝试修改共享资源，如果没有冲突就修改成功并退出否则就会继续下 一次循环尝试。

        所以，如果有多个线程修改同一个值必定会有一个线程能修改成功， 而其他修改失败的线程会不断重试直到修改成功。之前的文章我介绍过 JDK 的 CAS 原理及应用即是无锁的实现。

         可以看出，无锁是一种非常良好的设计，它不会出现线程出现的跳跃性问题，锁使 用不当肯定会出现系统性能问题，虽然无锁无法全面代替有锁，但无锁在某些场合 下是非常高效的。

##2.线程和进程的区别是什么？

    进程和线程的主要差别在于它们是不同的操作系统资源管理方式。进程有独立的地 址空间，一个进程崩溃后，在保护模式下不会对其它进程产生影响，
    而线程只是一 个进程中的不同执行路径。

    线程有自己的堆栈和局部变量，但线程之间没有单独的 地址空间，一个线程死掉就等于整个进程死掉，所以多进程的程序要比多线程的程序健壮，
    但在进程切换时，耗费资源较大，效率要差一些。

    但对于一些要求同时进行并且又要共享某些变量的并发操作，只能用线程，不能用进程。

##3.Java 实现线程有哪几种方式？

    （1）继承 Thread 类实现多线程
    
    （2）实现 Runnable 接口方式实现多线程
    
    （3）使用 ExecutorService、Callable、Future 实现有返回结果的多线程
    
    （4）通过线程池创建线程

##4.启动线程方法 start()和 run()有什么区别？

    只有调用了 start()方法，才会表现出多线程的特性，不同线程的 run()方法里面的代码交替执行。如果只是调用 run()方法，那么代码还是同步执行的，必须等待一个线程的 run()方法里面的代码全部执行完毕之后，另外一个线程才可以执行其 run() 方法里面的代码。

##5.怎么终止一个线程？如何优雅地终止线程？
    stop 终止，不推荐。

##6.一个线程的生命周期有哪几种状态？它们之间如何流转的？

    NEW：毫无疑问表示的是刚创建的线程，还没有开始启动。

    RUNNABLE: 表示线程已经触发 start()方式调用，线程正式启动，线程处于运行中 状态。

    BLOCKED：表示线程阻塞，等待获取锁，如碰到 synchronized、lock 等关键字等占用临界区的情况，一旦获取到锁就进行 RUNNABLE 状态继续运行。

    WAITING：表示线程处于无限制等待状态，等待一个特殊的事件来重新唤醒，如 通过wait()方法进行等待的线程等待一个 notify()或者 notifyAll()方法，通过 join()方 法进行等待的线程等待目标线程运行结束而唤醒，一旦通过相关事件唤醒线程，线 程就进入了 RUNNABLE 状态继续运行。

    TIMED_WAITING：表示线程进入了一个有时限的等待，如 sleep(3000)，等待 3 秒 后线程重新进行 RUNNABLE 状态继续运行。

    TERMINATED：表示线程执行完毕后，进行终止状态。需要注意的是，一旦线程通过start 方法启动后就再也不能回到初始 NEW 状态，线程终止后也不能再回到 RUNNABLE 状态 。

##7.线程中的 wait()和 sleep()方法有什么区别？

    这个问题常问，sleep 方法和 wait 方法都可以用来放弃 CPU 一定的时间，不同点在于如果线程持有某个对象的监视器，sleep 方法不会放弃这个对象的监视器，wait 方法会放弃这个对象的监视器。

##8.多线程同步有哪几种方法？

    Synchronized 关键字，Lock 锁实现，分布式锁等。

##9.多线程有什么用？

    1）发挥多核CPU的优势

    随着工业的进步，现在的笔记本、台式机乃至商用的应用服务器至少也都是双核的 ，4 核、8 核甚至 16 核的也都不少见，如果是单线程的程序，那么在双核 CPU 上 就浪费了 50%， 在 4 核 CPU 上就浪费了 75%。

    单核 CPU 上所谓的"多线程"那是 假的多线程，同一时间处理器只会处理一段逻辑，只不过线程之间切换得比较快， 看着像多个线程"同时"运行罢了。

    多核 CPU 上的多线程才是真正的多线程，它能 让你的多段逻辑同时工作，多线程，可以真正发挥出多核CPU 的优势来，达到充 分利用CPU 的目的。

    2）防止阻塞

    从程序运行效率的角度来看，单核 CPU 不但不会发挥出多线程的优势，反而会因 为在单核CPU 上运行多线程导致线程上下文的切换，而降低程序整体的效率。

    但 是单核 CPU 我们还是要应用多线程，就是为了防止阻塞。试想，如果单核 CPU 使 用单线程，那么只要这个线程阻塞了，比方说远程读取某个数据吧，对端迟迟未返 回又没有设置超时时间，那么你的整个程序在数据返回回来之前就停止运行了。

    多线程可以防止这个问题，多条线程同时运行，哪怕一条线程的代码执行读取数据阻 塞，也不会影响其它任务的执行。

    3）便于建模

    这是另外一个没有这么明显的优点了。假设有一个大的任务 A，单线程编程，那么 就要考虑很多，建立整个程序模型比较麻烦。但是如果把这个大的任务 A 分解成 几个小任务，任务B、任务 C、任务 D，分别建立程序模型，并通过多线程分别运 行这几个任务，那就简单很多了。

##10.多线程之间如何进行通信？

    wait/notify

##11、线程怎样拿到返回结果？

    实现Callable 接口。

##12、violatile 关键字的作用？

    一个非常重要的问题，是每个学习、应用多线程的 Java 程序员都必须掌握的。理 解 volatile关键字的作用的前提是要理解 Java 内存模型，这里就不讲 Java 内存模型 了，可以参见第31 点，volatile 关键字的作用主要有两个：

    1）多线程主要围绕可见性和原子性两个特性而展开，使用 volatile 关键字修饰的变 量，保证了其在多线程之间的可见性，即每次读取到 volatile 变量，一定是最新的数据。

    2）代码底层执行不像我们看到的高级语言----Java 程序这么简单，它的执行是 Java 代码–>字节码–>根据字节码执行对应的 C/C++代码–>C/C++代码被编译成汇编语 言–>和硬件电路交互，现实中，为了获取更好的性能 JVM 可能会对指令进行重排序，多线程下可能会出现一些意想不到的问题。

    使用 volatile 则会对禁止语义重排 序，当然这也一定程度上降低了代码执行效率从实践角度而言，volatile 的一个重 要 作 用 就 是 和 CAS 结 合。

##13、新建 T1、T2、T3 三个线程，如何保证它们按顺序执行？

    用 join 方法。

##14、怎么控制同一时间只有 3 个线程运行？

    用 Semaphore。

##15、为什么要使用线程池？

    我们知道不用线程池的话，每个线程都要通过 new Thread(xxRunnable).start()的方 式来创建并运行一个线程，线程少的话这不会是问题。

    而真实环境可能会开启多个线程让系统和程序达到最佳效率，当线程数达到一定数量就会耗尽系统的 CPU 和 内存资源，也会造成 GC频繁收集和停顿，因为每次创建和销毁一个线程都是要消 耗系统资源的。

    如果为每个任务都创建线程这无疑是一个很大的性能瓶颈。所以， 线程池中的线程复用极大节省了系统资源，当线程一段时间不再有任务处理时它也 会自动销毁，而不会长驻内存


##16、ThreadLocal
    ThreadLocal很容易让人望文生义，想当然地认为是一个“本地线程”。其实，ThreadLocal并不是一个Thread，而是Thread的局部变量，
    也许把它命名为ThreadLocalVariable更容易让人理解一些。
    当使用ThreadLocal维护变量时，ThreadLocal为每个使用该变量的线程提供独立的变量副本，所以每一个线程都可以独立地改变自己的副本，
    而不会影响其它线程所对应的副本。
    从线程的角度看，目标变量就象是线程的本地变量，这也是类名中“Local”所要表达的意思
    

##java多线程 —— 面试题集合（最全集合）
   https://blog.csdn.net/chongbin007/article/details/91359728
    
##java面试题：分布式   
   https://www.cnblogs.com/expiator/p/10201004.html



##线程、进程、协程的区别
    进程：是系统分配资源都基本单元，有独立的内存空间 比如一个迅雷应用程序，既不共享堆，亦不共享栈。一个进程中至少有一个线程。
    线程：线程是操作系统调度的最小单元线程拥有自己独立的栈和共享的堆，共享堆，不共享栈比如为在迅雷程序中开启多个下载任务下载就是多线程。
        如果只有单个线程，那么我们就只能下载一个任务，然后等待他下载完了再下载，而开启多个线程就可以同时下载多个任务。

    协程和线程一样共享堆，不共享栈，协程由程序员在协程的代码里显示调度。而线程是CPU进行调度。

    协程和线程的区别是：协程避免了无意义的调度，由此可以提高性能，但也因此，**程序员必须自己承担调度的责任，**同时，
    协程也失去了标准线程使用多CPU的能力。在线程里面可以开启协程，让程序在特定的时间内运行。也就是说一个线程执行不同的协程。

##Thread.Sleep(0)的作用
    因此，Thread.Sleep(0)的作用，就是“触发操作系统立刻重新进行一次CPU竞争”。给其他线程获得CPU执行一次的机会。
    竞争的结果也许是当前线程仍然获得CPU控制权，也许会换成别的线程获得CPU控制权。这也是我们在大循环里面经常会写一句Thread.Sleep(0) ，
    因为这样就给了其他线程比如Paint线程获得CPU控制权的权力。

##产生死锁之后如何查看
    用JPS定位进程号，
    用jstack查看线程死锁问题


