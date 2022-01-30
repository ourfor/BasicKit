//
//  OHDetailViewController.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/29.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHDetailViewController.h"
#import "OHPresentAnimation.h"
#import "OHDismissAnimation.h"
#import "OHSwipeDownInteractiveTransition.h"
#import <SDWebImage/SDWebImage.h>
#import "OHRandomImageViewModel.h"

@interface OHDetailViewController ()
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) OHRandomImageViewModel *viewModel;
@property (nonatomic, strong) OHSwipeDownInteractiveTransition *transition;
@end

@implementation OHDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [self _layout];
    [self _bind];
}

#pragma mark View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _refreshCoverImage];
}

#pragma mark Init
- (void)_setupUI {
    UIView *superview = self.view;
    superview.backgroundColor = UIColor.blueColor;
    [superview addSubview:self.coverImage];
}

- (void)_layout {
    UIView *superview = self.view;
    [self.coverImage remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(superview);
        make.top.left.equalTo(superview);
    }];
}

- (void)_bind {
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(_dismiss)];
    [self.view addGestureRecognizer:tapGesture];
    
    OHSwipeDownInteractiveTransition *transition = [[OHSwipeDownInteractiveTransition alloc] init];
    [transition wireToViewController:self];
    _transition = transition;
}

- (void)_dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)_refreshCoverImage {
    NSURL *imageUrl = [NSURL URLWithString:self.viewModel.randomImage];
    [self.coverImage sd_setImageWithURL:imageUrl];
}

#pragma mark UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[OHPresentAnimation alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[OHDismissAnimation alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transition.interacting ? self.transition : nil;
}


- (UIImageView *)coverImage {
    BeginLazyPropInit(coverImage)
    coverImage = [[UIImageView alloc] init];
    EndLazyPropInit(coverImage)
}

#pragma mark Getter
- (OHRandomImageViewModel *)viewModel {
    BeginLazyPropInit(viewModel)
    viewModel = [[OHRandomImageViewModel alloc] init];
    EndLazyPropInit(viewModel)
}
@end
