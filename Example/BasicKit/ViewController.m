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
@import BasicKit.Assets;

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <AvailabilityInternal.h>
#import "PanelView.h"
#import <objc/runtime.h>

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
    rectView.layer.cornerRadius = 50;
    [superview addSubview:rectView];
    rectView.translatesAutoresizingMaskIntoConstraints = NO;
    {
        NSArray *constraints = @[
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100],
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:100],
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:-60],
            [NSLayoutConstraint constraintWithItem:rectView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:20],
        ];
        [superview addConstraints:constraints];
    }
    
    UIView *rectView2 = [[UIView alloc] init];
    [superview addSubview:rectView2];
    rectView2.backgroundColor = UIColor.greenColor;
    rectView2.layer.cornerRadius = 50;
    rectView2.translatesAutoresizingMaskIntoConstraints = NO;
    
    {
        NSArray *constraints = @[
            [NSLayoutConstraint constraintWithItem:rectView2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100],
            [NSLayoutConstraint constraintWithItem:rectView2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:100],
            [NSLayoutConstraint constraintWithItem:rectView2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:-60],
            [NSLayoutConstraint constraintWithItem:rectView2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:-20],
        ];
        [superview addConstraints:constraints];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"使用FaceID" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.backgroundColor = UIColor.blackColor;
    button.layer.cornerRadius = 10;
    button.showsTouchWhenHighlighted = YES;
    button.adjustsImageWhenHighlighted = YES;
    button.titleLabel.font = [UIFont fontWithName:ASSET_FONT_ARITAHEITI_MEDIUM size:18];
    button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [superview addSubview:button];
    [button addTarget:self action:@selector(touchUsingFaceIDButton) forControlEvents:UIControlEventTouchUpInside];
    {
        NSArray<NSLayoutConstraint *> *constraints = @[
            [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:60],
            [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
        ];
        [superview addConstraints:constraints];
    }

    UIButton *buttonPop = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPop.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonPop setTitle:@"打开弹窗" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    buttonPop.backgroundColor = UIColor.blueColor;
    buttonPop.layer.cornerRadius = 10;
    buttonPop.showsTouchWhenHighlighted = YES;
    buttonPop.adjustsImageWhenHighlighted = YES;
    buttonPop.titleLabel.font = [UIFont fontWithName:ASSET_FONT_ARITAHEITI_MEDIUM size:18];
    buttonPop.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [superview addSubview:buttonPop];
    [buttonPop addTarget:self action:@selector(showPopPanel) forControlEvents:UIControlEventTouchUpInside];
    {
        NSArray<NSLayoutConstraint *> *constraints = @[
            [NSLayoutConstraint constraintWithItem:buttonPop attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeBottom multiplier:1 constant:60],
            [NSLayoutConstraint constraintWithItem:buttonPop attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
        ];
        [superview addConstraints:constraints];
    }

}

- (void)touchUsingFaceIDButton {
    [AuthUtil usingFaceID:^(LAContext * _Nonnull context) {
        [self writeDataToKeychainWithContext:context data:nil];
    }];
}

- (void)showPopPanel {
    UIView *panel = [[PanelContentView alloc] init];
    panel.backgroundColor = UIColor.grayColor;
    [panel addConstraint:[NSLayoutConstraint constraintWithItem:panel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:panel attribute:NSLayoutAttributeHeight multiplier:0 constant:400]];
    PanelView *panelView = [[PanelView alloc] initWithContentView:panel];
    [panelView showInView:self.view];
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
