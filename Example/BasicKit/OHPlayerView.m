//
//  OHPlayerView.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/28.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerAction.h"

@interface OHPlayerView ()
@property (nonatomic, weak) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIButton *exitButton;
@end

@implementation OHPlayerView

- (instancetype)initWithPlayer:(AVPlayer *)player {
    self = [super init];
    if (self) {
        _player = player;
        [self _setupUI];
        [self _layout];
        [self _bind];

    }
    return self;
}

- (void)_setupUI {
    self.backgroundColor = UIColor.blackColor;
    [self.layer addSublayer:self.playerLayer];
    [self addSubview:self.exitButton];
}

- (void)_layout {
    @weakify(self)
    [self.exitButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self).offset(STATUS_BAR_HEIGHT);
        make.left.equalTo(self).offset(24);
        make.width.height.equalTo(@36);
    }];
}

- (void)_bind {
    [self.exitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.playerLayer.player = self.player;
}

- (void)showInView:(UIView *)superview {
    [superview addSubview:self];
    @weakify(superview);
    [self remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.width.equalTo(superview);
        make.height.equalTo(superview);
        make.top.equalTo(superview.bottom);
    }];
    [superview layoutIfNeeded];
    [self remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.width.equalTo(superview);
        make.height.equalTo(superview);
        make.top.equalTo(superview);
    }];
    [UIView animateWithDuration:.4f animations:^{
        [superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.player play];
    }];
}

- (void)dismiss {
    [self remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.bottom);
    }];
    [UIView animateWithDuration:.5f animations:^{
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self pause];
        [self removeFromSuperview];
    }];
}

#pragma mark PlayerAction
- (void)play {
    [self.player setMuted:NO];
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (float)rate {
    return self.player.rate;
}
#pragma mark Getter
- (AVPlayerLayer *)playerLayer {
    BeginLazyPropInit(playerLayer)
    playerLayer = [[AVPlayerLayer alloc] init];
    playerLayer.frame = UIScreen.mainScreen.bounds;
    playerLayer.backgroundColor = UIColor.blackColor.CGColor;
    EndLazyPropInit(playerLayer)
}

- (UIButton *)exitButton {
    BeginLazyPropInit(exitButton)
    exitButton = [UIButton buttonWithType:UIButtonTypeClose];
    EndLazyPropInit(exitButton)
}
@end
