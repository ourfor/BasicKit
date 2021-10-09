//
//  PanelView.m
//  BasicKit_Example
//
//  Created by XuWang Real on 2021/9/16.
//  Copyright © 2021 曾谞旺. All rights reserved.
//

@import BasicKit.Timer;
@import BasicKit.UIView_Layout;

#import "PanelView.h"

@interface PanelView ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSLayoutConstraint *topEqualToBottom;
@property (nonatomic, strong) NSLayoutConstraint *bottomEqualToBottom;
@end

@implementation PanelView
- (instancetype)initWithContentView:(UIView * _Nonnull)contentView {
    self = [super init];
    if (self) {
        _contentView = contentView;
        [self setupUI];
        [self layout];
        [self bindAction];
    }
    return self;
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    {
        NSArray *constraints = @[
            [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0]
        ];
        [view addConstraints:constraints];
    }
    [self popUp:nil];
}

- (void)popUp:(void (^)(BOOL finished))completion {
    _bottomEqualToBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    _topEqualToBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraint:_topEqualToBottom];
    [self layoutIfNeeded];
    [self.contentView addCorner:UIRectCornerTopLeft|UIRectCornerTopRight ofSize:CGSizeMake(8, 8)];

    [self removeConstraint:_topEqualToBottom];
    [self addConstraint:_bottomEqualToBottom];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)popDown:(void (^)(BOOL finished))completion {
    [self removeConstraint:_bottomEqualToBottom];
    [self addConstraint:_topEqualToBottom];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)dismiss {
    [self popDown:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setupUI {
    [self addSubview:self.backgroundView];
    [self addSubview:self.contentView];
}

- (void)layout {
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    {
        NSArray *constraints = @[
            [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]
        ];
        [self addConstraints:constraints];
    }
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    {
        [self addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0],
        ]];
    }
}

- (void)bindAction {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.backgroundView addGestureRecognizer:tapGesture];
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}
@end

@implementation PanelContentView
- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.mask.frame = self.bounds;
}
@end
