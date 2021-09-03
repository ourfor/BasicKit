//
//  ColorUtil.h
//  GithubApp
//
//  Created by ourfor on 2021/6/3.
//

#define ColorRGBHex(rgb) [UIColor \
    colorWithRed: (float)((rgb & 0xff0000) >> 16)/255.0f \
           green: (float)((rgb & 0x00ff00) >> 8) /255.0f \
            blue: (float)((rgb & 0x0000ff) >> 0) /255.0f \
           alpha: 1.0f]
