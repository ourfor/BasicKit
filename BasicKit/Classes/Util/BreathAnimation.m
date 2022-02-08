//
//  BreathAnimation.m
//  BasicKit
//
//  Created by XuWang Real on 2022/2/8.
//

#import "BreathAnimation.h"

@implementation BreathAnimation

+ (CABasicAnimation *)animation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(1.0f);
    animation.toValue = @0;
    animation.autoreverses = YES;
    animation.duration = 2.0f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

@end
