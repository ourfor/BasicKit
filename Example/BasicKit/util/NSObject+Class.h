//
//  OHClassExchange.h
//  BasicKitApp
//
//  Created by XuWang Real on 2022/2/8.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Class)
- (void)setClass:(Class)clazz;
- (void)setMethod:(SEL)sel implement:(IMP)imp;
- (void)invokeSuperMethod:(SEL)sel;
@end

NS_ASSUME_NONNULL_END
