//
//  OHNetworkProxy.h
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/30.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OHNetworkProxyErrorHandler)(NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface OHNetworkProxy : NSObject
- (void)start:(OHNetworkProxyErrorHandler)callback;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
