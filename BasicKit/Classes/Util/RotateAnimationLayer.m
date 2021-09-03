//
//  AnimationRotate.m
//  GithubApp
//
//  Created by ourfor on 2021/6/7.
//

#import "RotateAnimationLayer.h"

@implementation RotateAnimationLayer
+ (instancetype)layer {
    CGSize size = UIScreen.mainScreen.bounds.size;
    CGPoint center = CGPointMake(size.width / 2, size.height / 2);
    size = CGSizeMake(36, 36);
    RotateAnimationLayer *layer = [super layer];
    layer.frame = CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height);
    
    CALayer *leftCircle = [CALayer layer];
    leftCircle.frame = CGRectMake(0, size.height / 4, size.width / 2, size.height / 2);
    leftCircle.cornerRadius = size.width / 4;
    leftCircle.backgroundColor = UIColor.redColor.CGColor;
    [layer addSublayer:leftCircle];
    
    CALayer *rightCircle = [CALayer layer];
    rightCircle.frame = CGRectMake(size.width / 2, size.height / 4, size.width / 2, size.height / 2);
    rightCircle.backgroundColor = UIColor.greenColor.CGColor;
    rightCircle.cornerRadius = size.width / 4;
    [layer addSublayer:rightCircle];
    
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.beginTime = 0;
    rotateAnimation.fromValue = @0;
    rotateAnimation.toValue = @(-2 * M_PI);
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *effect = CAAnimationGroup.animation;
    effect.duration = 0.8;
    effect.repeatCount = NSIntegerMax;
    effect.removedOnCompletion = NO;
    effect.animations = @[
        rotateAnimation,
    ];
    [layer addAnimation:effect forKey:@"animation"];
    
    return layer;
}
@end
