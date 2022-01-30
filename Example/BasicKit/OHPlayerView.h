//
//  OHPlayerView.h
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/28.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerAction.h"

@class AVPlayer;

NS_ASSUME_NONNULL_BEGIN

@interface OHPlayerView : UIView<PlayerAction>

- (instancetype)initWithPlayer:(AVPlayer *)player;
- (void)showInView:(UIView *)superview;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
