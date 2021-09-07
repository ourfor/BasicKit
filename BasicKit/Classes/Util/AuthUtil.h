//
//  AuthUtil.h
//  AuthUtil
//
//  Created by XuWang Real on 2021/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LAContext;

@interface AuthUtil : NSObject
+ (void)usingFaceID:(void (^)(LAContext *context))callback;
+ (BOOL)writeDataToKeychainWithContext:(LAContext *)context data:(NSDictionary<NSString *, id> *)data;
+ (NSDictionary<NSString *, id> *)readDataFromKeychainWithContext:(LAContext *)context query:(NSDictionary<NSString *, id> *)condition;
@end

NS_ASSUME_NONNULL_END
