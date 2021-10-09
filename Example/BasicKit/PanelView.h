//
//  PanelView.h
//  BasicKit_Example
//
//  Created by XuWang Real on 2021/9/16.
//  Copyright © 2021 曾谞旺. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PanelView : UIView
- (instancetype)initWithContentView:(UIView * _Nonnull)contentView;
- (void)showInView:(UIView *)view;
- (void)dismiss;
- (void)popUp:(void (^)(BOOL finished))completion;
- (void)popDown:(void (^)(BOOL finished))completion;
@end

@interface PanelContentView : UIView
- (instancetype)initWithCorner:(UIRectCorner)rectCorner ofSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
