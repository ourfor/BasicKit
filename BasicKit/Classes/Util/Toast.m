//
//  Toast.m
//  GithubApp
//
//  Created by ourfor on 2021/6/4.
//

#import "Toast.h"
#import "Assets.h"
#import "PopAnimation.h"
#import "ColorUtil.h"
#import "Timer.h"

@implementation Toast

+ (ToastBlock) success {
    return [self log:ASSET_IMAGE_TOAST_SUCCESS color:0x00cc00];
}

+ (ToastBlock)info {
    return [self log:ASSET_IMAGE_TOAST_INFO color:0x0000ff];
}

+ (ToastBlock)error {
    return [self log:ASSET_IMAGE_TOAST_ERROR color:0xff0000];
}

+ (ToastBlock)log:(StaticResourceType)iconType color:(NSInteger)hexColor {
    return ^(NSString *format, ...) {
        NSString *content = [NSString alloc];
        va_list args;
        va_start(args, format);
            content = [content initWithFormat:format arguments:args];
        va_end(args);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *container = [[UIView alloc] init];
            container.alpha = 0;
            container.backgroundColor = UIColor.whiteColor;
            container.layer.cornerRadius = 6;
            container.layer.masksToBounds = YES;
            container.layer.borderWidth = 1.5;
            container.layer.borderColor = ColorRGBHex(hexColor).CGColor;
            container.layer.shadowColor = ColorRGBHex(hexColor).CGColor;
            container.layer.shadowOffset = CGSizeMake(1, 1);
            CAAnimation *animation = PopAnimation.animation;
            CFTimeInterval offset = 2;
            CFTimeInterval duration = animation.duration + offset;
            [container.layer addAnimation:animation forKey:nil];

            UIImage *image = [UIImage imageNamed:iconType inBundle:assetBundle(self) compatibleWithTraitCollection:nil];
            UIImageView *icon = [[UIImageView alloc] initWithImage:image];
            NSNumber *iconWidth = @24;
            icon.layer.cornerRadius = iconWidth.floatValue / 2;
            icon.layer.masksToBounds = YES;

            [container addSubview:icon];

            {
                icon.translatesAutoresizingMaskIntoConstraints = NO;
                CGFloat iconSize = iconWidth.floatValue;
                NSArray *constraints = @[
                    [NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:0 constant:iconSize],
                    [NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0 constant:iconSize],
                    [NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTop multiplier:1 constant:4],
                    [NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeBottom multiplier:1 constant:-4],
                    [NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeading multiplier:1 constant:4]
                ];
                [container addConstraints:constraints];
            }

            UILabel *msg = [[UILabel alloc] init];
            msg.textColor = ColorRGBHex(hexColor);
            msg.text = content;
            msg.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            msg.textAlignment = NSTextAlignmentLeft;
            msg.lineBreakMode = NSLineBreakByWordWrapping;
            [msg setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            msg.font = [UIFont fontWithName:ASSET_FONT_ARITAHEITI_MEDIUM size:16];
            [container addSubview:msg];
            {
                msg.translatesAutoresizingMaskIntoConstraints = NO;
                NSArray *constraints = @[
                    [NSLayoutConstraint constraintWithItem:msg attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeTrailing multiplier:1 constant:4],
                    [NSLayoutConstraint constraintWithItem:msg attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeTrailing multiplier:1 constant:-6],
                    [NSLayoutConstraint constraintWithItem:msg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                ];
                [container addConstraints:constraints];
            }

            UIWindow *keywindow = nil;
            NSArray<UIWindow *> *windows = UIApplication.sharedApplication.windows;
            for (UIWindow *window in windows) {
                if (window.isKeyWindow) {
                    keywindow = window;
                    break;
                }
            }

            if (keywindow) {
                keywindow.translatesAutoresizingMaskIntoConstraints = NO;
                container.translatesAutoresizingMaskIntoConstraints = NO;
                [keywindow addSubview:container];

                {
                    NSArray *constraints = @[
                        [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:keywindow attribute:NSLayoutAttributeCenterX multiplier:1 constant:0],
                        [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:keywindow attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]
                    ];
                    [keywindow addConstraints:constraints];
                }
                
                [keywindow bringSubviewToFront:container];
                setTimeout(^{
                    [container removeFromSuperview];
                }, duration * TIME_UNIT_SEC);
            }
        });
    };
}

@end
