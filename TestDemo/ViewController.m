//
//  ViewController.m
//  TestDemo
//
//  Created by KenenCS on 2017/7/26.
//  Copyright © 2017年 KenenCS. All rights reserved.
//

#import "ViewController.h"
#import "myKVO.h"

@interface ViewController ()
//kvo类
@property (nonatomic,strong)myKVO *mykvo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     使用KVO无非就三步：
                    1.注册观察者；
                    2.在观察的属性变化的方法里面做处理；
                    3.移除KVO；
    */
    
    //初始化观察者对象
    self.mykvo = [[myKVO alloc] init];
    
    /*
     注册观察者的代码
     -----------参数简介----------
     *observer 观察者；
     *KeyPath 被观察的属性的名称；
     *options 被观察属性的一些配置，这里使用的，NSKeyValueObservingOptionOld代表观察旧值，NSKeyValueObservingOptionNew代表观察新值；
     *context 上下文，可以给kvo的回调方法传值；
     */
    [self.mykvo addObserver:self forKeyPath:@"num" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
    
}

/*
 只要你观察的keypath发生变化就会调用这个方法
 ----------------参数简介--------------
 *keypath 被观察的属性的名称；
 *object 被观察的对象；
 *change 前后变化的值都是储存在这个字典中的；
 *context 注册观察者时，context传过来的值；
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"num"] && object==self.mykvo) {
        
//        这里使用KVO就是为了改变label上的数字
        self.label.text = [NSString stringWithFormat:@"当前的num值是：%@",[change valueForKey:@"new"]];
        
//        [change valueForKey:@"new"]，代表新值，对应注册观察者时的NSKeyValueObservingOptionNew
//        [change valueForKey:@"old"],代表旧值，对应注册观察者时的NSKeyValueObservingOptionOld
        NSLog(@"旧值：%@  -----  新值：%@  -----",[change valueForKey:@"old"],[change valueForKey:@"new"]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//增加按钮点击事件
- (IBAction)changeNum:(UIButton *)sender {
    self.mykvo.num = self.mykvo.num+1;
}
//减少按钮点击事件
- (IBAction)jianShao:(UIButton *)sender {
    self.mykvo.num = self.mykvo.num-1;
}
//重置按钮点击事件
- (IBAction)chongZhi:(UIButton *)sender {
    self.mykvo.num = 0;
}

//移除kvo
-(void)dealloc {
    [self removeObserver:self forKeyPath:@"num"];
}

@end
