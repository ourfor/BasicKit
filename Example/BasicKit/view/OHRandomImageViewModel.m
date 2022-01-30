//
//  OHRandomImageViewModel.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/1/29.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHRandomImageViewModel.h"

@implementation OHRandomImageViewModel

- (NSString *)randomImage {
    CGSize size = UIScreen.mainScreen.bounds.size;
    return [NSString stringWithFormat:@"https://source.unsplash.com/random/%.0fx%.0f/?film,food,wallpapers", size.width, size.height];
}

@end
