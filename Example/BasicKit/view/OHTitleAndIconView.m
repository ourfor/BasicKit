//
//  OHTitleAndIconView.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/3/29.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHTitleAndIconView.h"

@implementation OHTitleAndIconView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _setupUI];
        [self _layout];
    }
    return self;
}

- (void)_setupUI {
    [self addSubview:self.iconView];
    [self addSubview:self.hintLabel];
}

- (void)_layout {
    @weakify(self);
    [self.iconView remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@24);
    }];
    
    [self.hintLabel remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.iconView);
        make.top.equalTo(self.iconView.bottom).with.offset(8);
    }];
    
    [self remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.iconView);
        make.left.equalTo(self.hintLabel);
        make.right.equalTo(self.hintLabel);
        make.bottom.equalTo(self.hintLabel);
    }];
}


#pragma mark Getter

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fruit_1"]];
    }
    return _iconView;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.font = [UIFont systemFontOfSize:22];
        _hintLabel.text = @"Hello World";
    }
    return _hintLabel;
}

@end
