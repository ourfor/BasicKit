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

#define VIEW_DISMISS_DURATION .6f
#define VIEW_PRESENT_DURATION .5f

@interface OHPlayerView ()
@property (nonatomic, weak) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIButton *exitButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *muteButton;
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, strong) UIImageView *playStatusView;

@property (nonatomic, assign) BOOL isMute;
@property (nonatomic, assign) BOOL isPlay;
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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)_setupUI {
    self.backgroundColor = UIColor.blackColor;
    [self.layer addSublayer:self.playerLayer];
    [self addSubview:self.playStatusView];
    [self addSubview:self.progressBar];
    [self addSubview:self.playButton];
    [self addSubview:self.muteButton];
    [self addSubview:self.exitButton];
}

- (void)_layout {
    @weakify(self)
    [self.playButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.height.equalTo(24);
        make.left.equalTo(self.progressBar);
        make.bottom.equalTo(self.progressBar.top).with.offset(-16);
    }];
    
    [self.muteButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.height.equalTo(24);
        make.right.equalTo(self.progressBar);
        make.bottom.equalTo(self.playButton);
    }];
    
    [self.exitButton remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.width.height.equalTo(@24);
        make.top.equalTo(self).offset(STATUS_BAR_HEIGHT);
        make.left.equalTo(self.progressBar);
    }];
    
    [self.progressBar remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.bottom.equalTo(self).offset(-40);
        make.height.equalTo(4);
        make.centerX.equalTo(self);
        make.width.equalTo(self).with.multipliedBy(0.8);
    }];
    
    [self.playStatusView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self);
        make.width.height.equalTo(@96);
    }];
}

- (void)_bind {
    [self.exitButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.playerLayer.player = self.player;
    self.progressBar.observedProgress = self.progress;
    @weakify(self);
    [RACObserve(self.player.currentItem, duration) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        Float64 total = CMTimeGetSeconds(self.player.currentItem.duration);
        if (total == NAN) {
            return;
        }
        [self.progress setTotalUnitCount:total];
    }];
    
    CMTime interval = CMTimeMakeWithSeconds(0.5, NSEC_PER_SEC);
    [self.player addPeriodicTimeObserverForInterval:interval queue:nil usingBlock:^(CMTime time) {
        @strongify(self);
        Float64 current = CMTimeGetSeconds(self.player.currentItem.currentTime);
        Float64 total = CMTimeGetSeconds(self.player.currentItem.duration);
        [self.progress setTotalUnitCount:total];
        [self.progress setCompletedUnitCount:current];
    }];
    
    self.isPlay = YES;
    RACChannelTo(self.player, muted) = RACChannelTo(self, isMute);
    [RACObserve(self, isMute) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        UIImage *icon = [UIImage imageNamed:self.isMute ? @"player_mute_on" : @"player_mute_off"];
        [self.muteButton setImage:icon forState:UIControlStateNormal];
    }];
    
    [RACObserve(self.player, rate) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.player.rate) {
            self.isPlay = YES;
        } else {
            self.isPlay = NO;
        }
    }];
    
    [RACObserve(self, isPlay) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        UIImage *icon = [UIImage imageNamed:self.isPlay ? @"player_play_on" : @"player_play_off"];
        [self.playButton setImage:icon forState:UIControlStateNormal];
        [self.playStatusView setImage:icon];
    }];
    [self.playButton addTarget:self action:@selector(_switchPlayStatus) forControlEvents:UIControlEventTouchUpInside];
    
    [self.muteButton addTarget:self action:@selector(_switchMuteStatus) forControlEvents:UIControlEventTouchUpInside];
    
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_switchControlsVisible)];
    [self addGestureRecognizer:tapGesture];
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
    [self updateConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.top.equalTo(superview);
    }];
    [UIView animateWithDuration:VIEW_PRESENT_DURATION animations:^{
        [superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.player play];
    }];
}

- (void)dismiss {
    @weakify(self);
    [self remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(self.superview.width);
        make.height.equalTo(self.superview.height);
        make.top.equalTo(self.superview.bottom);
    }];
    [UIView animateWithDuration:VIEW_DISMISS_DURATION animations:^{
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self pause];
        [self removeFromSuperview];
    }];
}

#pragma mark PlayerAction
- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (float)rate {
    return self.player.rate;
}

- (void)_switchPlayStatus {
    if (self.isPlay) {
        [self pause];
    } else {
        [self play];
    }
}

- (void)_switchMuteStatus {
    if (self.isMute) {
        self.player.muted = NO;
    } else {
        self.player.muted = YES;
    }
}

- (void)_switchControlsVisible {
    BOOL isHidden = self.progressBar.hidden;
    NSArray<UIView *> *views = @[self.progressBar, self.playButton, self.muteButton, self.exitButton, self.playStatusView];
    for (UIView *view in views) {
        view.hidden = NO;
    }
    
    [UIView animateWithDuration:.5f animations:^{
        CGFloat alpha = isHidden ? 1 : 0;
        for (UIView *view in views) {
            view.alpha = alpha;
        }
    } completion:^(BOOL finished) {
        for (UIView *view in views) {
            view.hidden = !isHidden;
        }
    }];
}

#pragma mark Getter
- (AVPlayerLayer *)playerLayer {
    BeginLazyPropInit(playerLayer)
    playerLayer = [[AVPlayerLayer alloc] init];
    playerLayer.frame = UIScreen.mainScreen.bounds;
    playerLayer.backgroundColor = UIColor.blackColor.CGColor;
    EndLazyPropInit(playerLayer)
}

- (UIProgressView *)progressBar {
    BeginLazyPropInit(progressBar)
    progressBar = [[UIProgressView alloc] init];
    [progressBar setProgressViewStyle:UIProgressViewStyleBar];
    progressBar.progressTintColor = UIColor.whiteColor;
    progressBar.trackTintColor = [UIColor.whiteColor colorWithAlphaComponent:0.3];
    progressBar.layer.cornerRadius = 3;
    progressBar.clipsToBounds = YES;
    EndLazyPropInit(progressBar)
}

- (UIImageView *)playStatusView {
    BeginLazyPropInit(playStatusView)
    playStatusView = [[UIImageView alloc] init];
    EndLazyPropInit(playStatusView)
}

- (UIButton *)playButton {
    BeginLazyPropInit(playButton)
    playButton = [[UIButton alloc] init];
    UIImage *icon = [UIImage imageNamed:@"player_play_on"];
    [playButton setImage:icon forState:UIControlStateNormal];
    EndLazyPropInit(playButton)
}

- (UIButton *)muteButton {
    BeginLazyPropInit(muteButton)
    muteButton = [[UIButton alloc] init];
    UIImage *icon = [UIImage imageNamed:@"player_mute_off"];
    [muteButton setImage:icon forState:UIControlStateNormal];
    EndLazyPropInit(muteButton)
}

- (UIButton *)exitButton {
    BeginLazyPropInit(exitButton)
    exitButton = [[UIButton alloc] init];
    UIImage *icon = [UIImage imageNamed:@"player_exit"];
    [exitButton setImage:icon forState:UIControlStateNormal];
    EndLazyPropInit(exitButton)
}

- (NSProgress *)progress {
    BeginLazyPropInit(progress)
    progress = [[NSProgress alloc] init];
    EndLazyPropInit(progress)
}
@end
