//
//  AuthUtil.m
//  AuthUtil
//
//  Created by XuWang Real on 2021/9/7.
//

@import LocalAuthentication;

#import "AuthUtil.h"
#import "Logger.h"

@implementation AuthUtil

+ (void)usingFaceID:(void (^)(LAContext *))callback {
    LAContext *context = [[LAContext alloc] init];
    Logger *log = [Logger sharedInstance];
    context.localizedCancelTitle = @"Enter Username/Password";
    context.touchIDAuthenticationAllowableReuseDuration = 10;
    NSError *error;
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error) {
        log.error(@"unable FaceID %@", error);
    } else {
        NSString *reason = @"Log in to your account";
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                log.info(@"authorization success");
                callback(context);
            } else {
                log.error(@"authorization failed with reason: %@", error.localizedDescription ?: @"Failed to authenticate");
            }
        }];
    }
}

/**
 * @param condition NSDictionary must include kSecAttrServer kSecMatchLimit
 */
+ (NSDictionary<NSString *,id> *)readDataFromKeychainWithContext:(LAContext *)context query:(NSDictionary<NSString *, id> *)condition {
    SecAccessControlRef access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, kSecAccessControlUserPresence, nil);
    NSString *prompt = @"Access your password on the keychain";
    if (@available(iOS 11.0, *)) {
        context.localizedReason = prompt;
    }
    NSDictionary<NSString *, id> *query = @{
        (__bridge NSString *)kSecClass: (__bridge id)kSecClassInternetPassword,
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_14_0
        (__bridge NSString *)kSecUseOperationPrompt: prompt,
#endif
        (__bridge NSString *)kSecAttrAccessControl: (__bridge id)access,
        (__bridge NSString *)kSecUseAuthenticationContext: context,
        (__bridge NSString *)kSecReturnAttributes: @(YES),
        (__bridge NSString *)kSecReturnData: @(YES),
        (__bridge  NSString *)kSecAttrServer: condition[@"server"] ?: @"",
        (__bridge NSString *)kSecMatchLimit: condition[@"match_limit"] ?: (__bridge id)kSecMatchLimitOne
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

/**
 * @param data NSDirectory include kSecAttrServer kSecAttrAccount kSecValueData
 * @see https://developer.apple.com/documentation/localauthentication/accessing_keychain_items_with_face_id_or_touch_id?language=objc
 */

+ (BOOL)writeDataToKeychainWithContext:(LAContext *)context data:(NSDictionary<NSString *,id> *)data {
    SecAccessControlRef access = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, kSecAccessControlUserPresence, nil);
    NSDictionary<NSString *, id> *query = @{
        (__bridge NSString *)kSecClass: (__bridge id)kSecClassInternetPassword,
        (__bridge NSString *)kSecAttrAccessControl: (__bridge id)access,
        (__bridge NSString *)kSecUseAuthenticationContext: context,
        (__bridge NSString *)kSecAttrAccount: data[@"account"] ?: @"",
        (__bridge NSString *)kSecAttrServer: data[@"server"] ?: @"",
        (__bridge NSString *)kSecValueData: data[@"value"] ?: [@"" dataUsingEncoding:NSUTF8StringEncoding]
    };
    
    Logger *log = [Logger sharedInstance];
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, nil);
    if (status == errSecSuccess) {
        log.info(@"save user info successfully");
    } else {
        if (status == errSecDuplicateItem) {
            log.error(@"error occurred, reason %@", @"duplicate item");
        } else {
            log.error(@"error occurred, reason %@", @"unknown");
        }
    }
    return status == errSecSuccess;
}
@end
