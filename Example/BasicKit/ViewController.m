//
//  OHViewController.m
//  BasicKit
//
//  Created by 曾谞旺 on 09/03/2021.
//  Copyright (c) 2021 曾谞旺. All rights reserved.
//

#import "ViewController.h"
#import <BasicKit/Toast.h>
#import <BasicKit/BasicKit.h>
#import <BasicKit/Logger.h>
#import <BasicKit/Timer.h>
#import <BasicKit/ColorUtil.h>
#import <BasicKit/PopAnimation.h>
#import <BasicKit/BasicKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import <LocalAuthentication/LocalAuthentication.h>

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
    [self usingFaceID];
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

- (void)usingFaceID {
    LAContext *context = [[LAContext alloc] init];
    context.localizedCancelTitle = @"Enter Username/Password";
    context.touchIDAuthenticationAllowableReuseDuration = 10;
    NSError *error;
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error) {
        Toast.error(@"无法使用FaceID %@", error);
    } else {
        NSString *reason = @"Log in to your account";
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                Toast.success(@"授权成功");
                
//                [self writeDataToKeychainWithContext:context];
                [self readDataFromKeychainWithContext:context];
            } else {
                Toast.error(@"授权失败，失败原因: %@", error.localizedDescription ?: @"Failed to authenticate");
            }
        }];
    }
}

- (void)writeDataToKeychainWithContext:(LAContext *)context data:(NSDictionary<NSString *, id> *)data {
    SecAccessControlRef access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, kSecAccessControlUserPresence, nil);
    NSString *account = @"ourfor";
    NSString *password = @"123abc$$";
    NSString *server = @"passport.ourfor.top";
    NSDictionary<NSString *, id> *query = @{
        (__bridge NSString *)kSecClass: (__bridge id)kSecClassInternetPassword,
        (__bridge NSString *)kSecAttrAccount: account,
        (__bridge NSString *)kSecAttrServer: server,
        (__bridge NSString *)kSecAttrAccessControl: (__bridge id)access,
        (__bridge NSString *)kSecUseAuthenticationContext: context,
        (__bridge NSString *)kSecValueData: [password dataUsingEncoding:NSUTF8StringEncoding]
    };
    
    [data enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [query setValue:obj forKey:key];
    }];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, nil);
    if (status == errSecSuccess) {
        Toast.success(@"用户信息保存成功");
    } else {
        if (status == errSecDuplicateItem) {
            Toast.error(@"error occurred, reason %@", @"duplicate item");
        } else {
            Toast.error(@"error occurred, reason %@", @"unknown");
        }
    }
}

- (NSDictionary<NSString *, id> *)readDataFromKeychainWithContext:(LAContext *)context {
    SecAccessControlRef access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, kSecAccessControlUserPresence, nil);
    NSString *server = @"passport.ourfor.top";
    NSString *prompt = @"Access your password on the keychain";
    context.localizedReason = prompt;
    NSDictionary<NSString *, id> *query = @{
        (__bridge NSString *)kSecClass: (__bridge id)kSecClassInternetPassword,
        (__bridge NSString *)kSecAttrServer: server,
        (__bridge NSString *)kSecMatchLimit: (__bridge  id)kSecMatchLimitOne,
        (__bridge NSString *)kSecUseOperationPrompt: prompt,
        (__bridge NSString *)kSecAttrAccessControl: (__bridge id)access,
        (__bridge NSString *)kSecUseAuthenticationContext: context,
        (__bridge NSString *)kSecReturnAttributes: @(YES),
        (__bridge NSString *)kSecReturnData: @(YES)
    };

    CFTypeRef data = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &data);
    if (status == errSecSuccess) {
        NSDictionary<NSString *, id> *dict = (__bridge NSDictionary *)data;
        return dict;
    } else {
        return nil;
    }
}
@end
