//
//  myKvo.m
//  TestDemo
//
//  Created by KenenCS on 2017/7/26.
//  Copyright © 2017年 KenenCS. All rights reserved.
//

#import "myKVO.h"
#import <UIKit/UIKit.h>

@implementation myKVO
//
@synthesize num;

//num的setter方法，设置界限在0-100之内
- (void)setNum:(int)newNum {
    if (newNum>100||newNum<0) {//有界限
        NSLog(@"超界了");
    }else {//正常赋值
        num = newNum;
    }
}

//num的getter方法
- (int)num {
    return num;
}

@end

