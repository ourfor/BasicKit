//
//  OHAppDelegate.m
//  BasicKit
//
//  Created by 曾谞旺 on 09/03/2021.
//  Copyright (c) 2021 曾谞旺. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] init];
    UIViewController *viewController = [[ViewController alloc] init];
    viewController.view.backgroundColor = UIColor.whiteColor;
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigation.navigationBarHidden = YES;
    _window.rootViewController = navigation;
    [_window makeKeyAndVisible];
    return YES;
}

@end
