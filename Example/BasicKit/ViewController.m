//
//  OHViewController.m
//  BasicKit
//
//  Created by 曾谞旺 on 09/03/2021.
//  Copyright (c) 2021 曾谞旺. All rights reserved.
//
@import BasicKit.Toast;
@import BasicKit.Logger;
@import BasicKit.Timer;
@import BasicKit.AuthUtil;

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <AvailabilityInternal.h>

@interface ViewController ()
@property (nonatomic, strong) Timer timer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    Logger *log = [Logger sharedInstance];
    log.info(@"Good %@", @"BB");
    log.warn(@"%@ 你好👋", @"AA");
    Toast.success(@"%@ 你好👋, 分手多日，近况如何？ 奉读大示，心折殊深。 惠书敬悉，迟复为歉。 近来寒暑不常，希自珍慰。 久不通函，至以为念。 前上一函，谅达雅鉴，迄今未闻复音。", @"AA");
    setTimeout(^{
        log.info(@"Hello World");
    }, 5 * TIME_UNIT_SEC);
    setInterval(^{
//        log.warn(@"%@ 你好👋", @"BB");
//        Toast.success(@"%@ 你好👋", @"AA");
    }, 2 * TIME_UNIT_SEC);
    [AuthUtil usingFaceID:^(LAContext * _Nonnull context) {
        [self writeDataToKeychainWithContext:context data:nil];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    UIView *superview = self.view;
    UIView *rectView = [[UIView alloc] init];
    rectView.backgroundColor = UIColor.redColor;
    [superview addSubview:rectView];
    rectView.translatesAutoresizingMaskIntoConstraints = NO;
    {
        NSArray *constraints = @[
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100],
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:100],
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
        ];
        [superview addConstraints:constraints];
    }
}


- (void)writeDataToKeychainWithContext:(LAContext *)context data:(NSDictionary<NSString *, id> *)data {
    NSDictionary<NSString *, id> *query = @{
        @"server": @"passport.apple.com",
        @"account": @"hi@ourfor.top",
        @"value": [@"abc123MM" dataUsingEncoding:NSUTF8StringEncoding]
    };
    BOOL isSaved = [AuthUtil writeDataToKeychainWithContext:context data:query];
    if (isSaved) {
        Toast.success(@"保存成功");
    }
}

- (NSDictionary<NSString *, id> *)readDataFromKeychainWithContext:(LAContext *)context {
    NSDictionary *query = @{
        @"server": @"passport.ourfor.top",
        @"match_limit": (__bridge id)kSecMatchLimitOne
    };
    NSDictionary<NSString *, id> *data = [AuthUtil readDataFromKeychainWithContext:context query:query];
    NSString *account = data[(__bridge NSString *)kSecAttrAccount];
    NSData *passwordData = data[(__bridge NSString *)kSecValueData];
    NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
    Toast.success(@"account: %@, password: %@", account, password);
    return data;
}
@end
