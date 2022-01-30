//
//  PlayerAction.h
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/29.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerAction <NSObject>
@property (nonatomic, readonly) float rate;

- (void)play;
- (void)pause;

@optional
- (void)showInView:(UIView *)superview;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
