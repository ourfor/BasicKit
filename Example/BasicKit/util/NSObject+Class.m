//
//  OHClassExchange.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/2/8.
//  Copyright © 2022 曾谞旺. All rights reserved.
//
#import "NSObject+Class.h"
//#import <objc/runtime.h>
#import <objc/runtime.h>
#import <objc/message.h>

typedef void (*CallSuperMethod)(void *, SEL, ...);
typedef void (*CallMethod)(void *, SEL, ...);

@implementation NSObject (Class)

- (void)setClass:(Class)clazz {
    object_setClass(self, clazz);
}

- (void)setMethod:(SEL)sel implement:(IMP)imp {
    NSString *oldClass = NSStringFromClass(self.class);
    NSString *newClass = [NSString stringWithFormat:@"%@_%@", oldClass, NSStringFromSelector(sel)];
    Class clazz = objc_allocateClassPair(self.class, newClass.UTF8String, 0);
    objc_registerClassPair(clazz);
    object_setClass(self, clazz);
    class_addMethod(clazz, sel, imp, "v@:@");
}

- (void)invokeSuperMethod:(SEL)sel {
    struct objc_super superClass = {
        self,
        class_getSuperclass(self.class)
    };
    CallSuperMethod call = (CallSuperMethod)objc_msgSendSuper;
    call(&superClass, sel);
}

@end
