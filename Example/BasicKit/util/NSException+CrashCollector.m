//
//  NSException+CrashCollector.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/4/21.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "NSException+CrashCollector.h"

void uncatchedExceptionHandler(NSException *exception) {
    NSArray<NSString *> *callstack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSDictionary *report = @{
        @"name"         : name,
        @"reason"       : reason,
        @"callstack"    : callstack
    };
}

void registerUncatchedExceptionHandler() {
    if (NSGetUncaughtExceptionHandler() != uncatchedExceptionHandler) {
        NSSetUncaughtExceptionHandler(uncatchedExceptionHandler);
    }
}

@implementation NSException (CrashCollector)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        registerUncatchedExceptionHandler();
    });
}

+ (void)setDefaultExceptionHandler {
    registerUncatchedExceptionHandler();
}
@end
