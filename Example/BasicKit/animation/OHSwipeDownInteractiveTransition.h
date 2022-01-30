//
//  OHSwipeDowInteractiveTransition.h
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/30.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OHSwipeDownInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
