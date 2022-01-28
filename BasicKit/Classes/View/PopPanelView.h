//
//  PopupView.h
//  BasicKit
//
//  Created by XuWang Real on 2021/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopPanelView : UIView
- (instancetype)initWithContentView:(UIView * _Nonnull)contentView;
- (void)showInView:(UIView *)view;
- (void)dismiss;
- (void)popUp:(void (^)(BOOL finished))completion;
- (void)popDown:(void (^)(BOOL finished))completion;
@end

@interface PopPanelContentView : UIView
@property (nonatomic, assign) UIRectCorner cornerRect;
@property (nonatomic, assign) CGSize cornerSize;
- (instancetype)initWithCorner:(UIRectCorner)rectCorner ofSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
