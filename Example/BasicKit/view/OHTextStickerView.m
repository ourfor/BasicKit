//
//  OHTextStickerView.m
//  BasicKitApp
//
//  Created by XuWang Real on 2021/12/7.
//  Copyright © 2021 曾谞旺. All rights reserved.
//

#import "OHTextStickerView.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation OHTextStickerModel
@end

@interface OHTextStickerView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textView;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) UIImage *image;
@end

@implementation OHTextStickerView

- (instancetype)initWithModel:(OHTextStickerModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
        [self _setupUI];
        [self _layout];
        [self _bind];
    }
    return self;
}


- (void)_setupUI {
    [self _updateContentSize];
    UIFont *font = [UIFont systemFontOfSize:18];
    self.textView.font = font;
    self.textView.text = self.model.text;
    self.imageView.image = self.image;
    
    UIView *superview = self;
    [superview addSubview:self.imageView];
    [superview addSubview:self.textView];
}

- (void)_layout {
    [self _updateContentSize];
    CGSize contentSize = _contentSize;
    UIEdgeInsets padding = self.model.padding;
    CGFloat scale = _scale;
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(contentSize.width));
        make.height.equalTo(@(contentSize.height));
    }];
    
    @weakify(self);
    [self.textView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self).with.offset(padding.top * scale);
        make.left.equalTo(self).with.offset(padding.left * scale);
        make.right.equalTo(self).with.offset(-padding.right * scale);
        make.bottom.equalTo(self).with.offset(-padding.bottom * scale);
    }];
    
    [self.imageView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(self);
        make.height.equalTo(self);
        make.edges.equalTo(self);
    }];
}

- (void)_updateContentSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = self.model.text;
    label.font = [UIFont systemFontOfSize:18];
    CGSize textDisplaySize = [label sizeThatFits:CGSizeMake((double)(unsigned int)-1, (double)(unsigned int)-1)];
    UIImage *giftImage = [UIImage imageNamed:self.model.image];
    CGSize imageSize = giftImage.size;
    UIEdgeInsets padding = self.model.padding;
    
    CGFloat contentHeight = imageSize.height - padding.top - padding.bottom;
    
    
    /// scale = display : origin
    CGFloat scale = textDisplaySize.height / contentHeight;
    

    
    CGSize contentSize = CGSizeMake(
        (padding.left + padding.right) * scale + textDisplaySize.width,
        imageSize.height * scale
    );
    
    _scale = scale;
    _contentSize = contentSize;
}

- (void)_bind {
    @weakify(self);
    [RACObserve(self.model, text) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self _layout];
        self.textView.text = self.model.text;
    }];
}

- (UIImage *)image {
    if (!_image) {
        UIImage *originImage = [UIImage imageNamed:self.model.image];
        CGSize imageSize = originImage.size;
        CGFloat scale = _scale;
        UIEdgeInsets padding = self.model.padding;
        CGFloat deviceScale = UIScreen.mainScreen.scale;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSize.width * scale, imageSize.height * scale), NO, deviceScale);
        [originImage drawInRect:CGRectMake(0, 0, imageSize.width * scale, imageSize.height * scale)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIEdgeInsets scaledPadding = UIEdgeInsetsMake(padding.top * scale, padding.left * scale, padding.bottom * scale, padding.right * scale);
        _image = [scaledImage resizableImageWithCapInsets:scaledPadding resizingMode:UIImageResizingModeStretch];
    }
    return _image;
}

- (UILabel *)textView {
    if (!_textView) {
        _textView = [[UILabel alloc] init];
    }
    return _textView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
