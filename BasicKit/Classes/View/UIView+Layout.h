//
//  UIView.h
//  BasicKit
//
//  Created by XuWang Real on 2021/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Layout)
- (void)addCorner:(UIRectCorner)rectCorner ofSize:(CGSize)size;
- (void)addCorner:(UIRectCorner)rectCorner ofSize:(CGSize)size frame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
