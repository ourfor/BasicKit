//
//  OHSwipeDowInteractiveTransition.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/30.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHSwipeDownInteractiveTransition.h"

@interface OHSwipeDownInteractiveTransition ()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
@end

@implementation OHSwipeDownInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController {
    self.presentingVC = viewController;
    [self _prepareGestureRecognizerInView:viewController.view];
}

- (void)_prepareGestureRecognizerInView:(UIView *)view {
    UIGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_handleSwipeGesture:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)_handleSwipeGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat percent = translation.y / 400.0f;
            percent = fminf(fmaxf(percent, 0.0f), 1.0f);
            self.shouldComplete = (percent > 0.3);
            [self updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
