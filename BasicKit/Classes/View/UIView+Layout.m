//
//  UIView.m
//  BasicKit
//
//  Created by XuWang Real on 2021/9/18.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (void)addCorner:(UIRectCorner)rectCorner ofSize:(CGSize)size {
    [self addCorner:rectCorner ofSize:size frame:self.bounds];
}

- (void)addCorner:(UIRectCorner)rectCorner ofSize:(CGSize)size frame:(CGRect)frame {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
@end
