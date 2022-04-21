//
//  NSArray+OutOfIndexExceptionCatch.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/4/21.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "NSArray+IndexCheck.h"
#import <objc/runtime.h>

@implementation NSArray (IndexCheck)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getInstanceMethod(NSClassFromString(@"NSConstantArray"), @selector(objectAtIndexedSubscript:));
        Method newMethod = class_getInstanceMethod(self.class, @selector(objectAtIndexedSubscriptWithIndexCheck:));
        method_exchangeImplementations(oldMethod, newMethod);
    });
}

- (id)objectAtIndexedSubscriptWithIndexCheck:(NSUInteger)idx {
    if (idx < self.count) {
        return [self objectAtIndexedSubscriptWithIndexCheck:idx];
    }
    NSLog(@"%ld > %ld", idx, self.count);
    return nil;
}

@end
