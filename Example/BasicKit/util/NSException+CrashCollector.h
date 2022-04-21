//
//  NSException+CrashCollector.h
//  BasicKitApp
//
//  Created by XuWang Real on 2022/4/21.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSException (CrashCollector)
+ (void)setDefaultExceptionHandler;
@end

NS_ASSUME_NONNULL_END
