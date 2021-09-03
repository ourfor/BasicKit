//
//  PopAnimation.m
//  GithubApp
//
//  Created by ourfor on 2021/6/7.
//

#import "PopAnimation.h"
#import <UIKit/UIKit.h>

@implementation PopAnimation
+ (instancetype)animation {
    PopAnimation *effect = [super animation];
    if (effect) {
        effect.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        CGSize size = UIScreen.mainScreen.bounds.size;
        CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animation];
        moveAnimation.keyPath = @"position";
        moveAnimation.keyTimes = @[@0, @0.3f, @1.0f];
        moveAnimation.values = @[
            [NSValue valueWithCGPoint:CGPointMake(size.width / 2, size.height)],
            [NSValue valueWithCGPoint:CGPointMake(size.width / 2, size.height / 2)],
            [NSValue valueWithCGPoint:CGPointMake(size.width / 2, size.height / 2)]
        ];
        moveAnimation.beginTime = 0;
        moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.keyTimes = @[@0, @0.3f, @0.8f, @1.0f];
        opacityAnimation.values = @[@0, @1.0, @1.0, @0];
        opacityAnimation.beginTime = 0;
        
        effect.duration = 3;
        effect.animations = @[
            moveAnimation,
            opacityAnimation
        ];
    }

    return effect;
}
@end
