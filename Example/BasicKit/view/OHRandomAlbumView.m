//
//  OHRandomAlbumView.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/29.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHRandomAlbumView.h"

@interface OHRandomAlbumView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation OHRandomAlbumView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _setupUI];
        [self _layout];
        [self _bind];
    }
    return self;
}


#pragma mark Init
- (void)_setupUI {
    UIView *superview = self;
    [superview addSubview:self.collectionView];
}

- (void)_layout {
    UIView *superview = self;
    @weakify(superview);
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        @strongify(superview);
        make.width.equalTo(superview);
        make.height.equalTo(superview).offset(-10);
    }];
}

- (void)_bind {
    
}


- (UICollectionView *)collectionView {
    BeginLazyPropInit(collectionView);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, self.frame.size.height)];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    EndLazyPropInit(collectionView);
}
@end
