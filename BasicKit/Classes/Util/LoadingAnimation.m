//
//  LoadUtil.m
//  GithubApp
//
//  Created by ourfor on 2021/6/4.
//

#import <UIKit/UIKit.h>
#import "LoadingAnimation.h"
#import "RotateAnimationLayer.h"

static CALayer *layer = nil;

@implementation LoadingAnimation
+ (void)start {
    UIWindow *keywindow = [self keywindow];
    if (keywindow) {
        if (layer == nil) {
            @synchronized (layer) {
                if (layer == nil) {
                    layer = [RotateAnimationLayer layer];
                }
            }
        }
        [keywindow.layer addSublayer:layer];
    }
}

+ (void)stop {
    [layer removeFromSuperlayer];
}

+ (UIWindow *) keywindow {
    NSArray<UIWindow *> *windows = UIApplication.sharedApplication.windows;
    UIWindow *ret = nil;
    for (UIWindow *window in windows) {
        if (window.isKeyWindow) {
            ret = window;
            break;
        }
    }
    return ret;
}
@end
