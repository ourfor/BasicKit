//
//  OHNavigationViewController.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/2/8.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHNavigationController.h"

@implementation OHNavigationController

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

@end
