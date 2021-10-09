//
//  main.m
//  BasicKit
//
//  Created by 曾谞旺 on 09/03/2021.
//  Copyright (c) 2021 曾谞旺. All rights reserved.
//

@import UIKit;
#import "AppDelegate.h"

__attribute__((constructor)) static void beforeFn() {
    
}

__attribute__((destructor)) static void afterFn() {
    
}

int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
