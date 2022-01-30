//
//  OHTextStickerView.h
//  BasicKitApp
//
//  Created by XuWang Real on 2021/12/7.
//  Copyright © 2021 曾谞旺. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OHTextStickerModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) UIEdgeInsets padding;
@end

@interface OHTextStickerView : UIView
@property (nonatomic, strong) OHTextStickerModel *model;

- (instancetype)initWithModel:(OHTextStickerModel *)model;
@end

NS_ASSUME_NONNULL_END
