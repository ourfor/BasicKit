#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BasicKit.h"
#import "Assets.h"
#import "ColorUtil.h"
#import "LoadingAnimation.h"
#import "LocalizationUtil.h"
#import "Logger.h"
#import "PopAnimation.h"
#import "RotateAnimationLayer.h"
#import "Timer.h"
#import "Toast.h"
#import "Util.h"
#import "Alert.h"

FOUNDATION_EXPORT double BasicKitVersionNumber;
FOUNDATION_EXPORT const unsigned char BasicKitVersionString[];

