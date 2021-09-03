//
//  Toast.h
//  GithubApp
//
//  Created by ourfor on 2021/6/4.
//

#import <UIKit/UIKit.h>

typedef void (^ToastBlock) (NSString *content, ...);

@interface Toast : NSObject
+ (ToastBlock) info;
+ (ToastBlock) error;
+ (ToastBlock) success;

@end
