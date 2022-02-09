//
//  OHAppDelegate.m
//  BasicKit
//
//  Created by 曾谞旺 on 09/03/2021.
//  Copyright (c) 2021 曾谞旺. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSObject+Class.h"

@implementation AppDelegate

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] init];
    UIViewController *viewController = [[ViewController alloc] init];
    viewController.view.backgroundColor = UIColor.whiteColor;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    IMP imp = [self methodForSelector:@selector(shouldAutorotate)];
    [navigation setMethod:@selector(shouldAutorotate) implement:imp];
    navigation.navigationBarHidden = YES;
    _window.rootViewController = navigation;
    [_window makeKeyAndVisible];
    return YES;
}

@end
