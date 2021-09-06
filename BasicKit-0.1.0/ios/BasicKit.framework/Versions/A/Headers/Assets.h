//
//  Header.h
//  GithubApp
//
//  Created by ourfor on 2021/5/28.
//

#import <Foundation/Foundation.h>

#ifndef Assets_h
#define Assets_h

typedef NSString * const StaticResourceType;
typedef StaticResourceType ConstString;

extern StaticResourceType ASSET_FONT_ARITAHEITI_MEDIUM;
extern StaticResourceType ASSET_FONT_FIRACODE_BOLD;
extern StaticResourceType ASSET_FONT_FIRACODE_LIGHT;
extern StaticResourceType ASSET_FONT_FIRACODE_MEDIUM;
extern StaticResourceType ASSET_FONT_FIRACODE_REGULAR;
extern StaticResourceType ASSET_FONT_FIRACODE_RETINA;
extern StaticResourceType ASSET_FONT_FIRACODE_SEMIBOLD;
extern StaticResourceType ASSET_IMAGE_GITHUB_ICON;
extern StaticResourceType ASSET_IMAGE_GITHUB_REPOS;
extern StaticResourceType ASSET_IMAGE_GITHUB_ISSUES;
extern StaticResourceType ASSET_IMAGE_GITHUB_REQS;
extern StaticResourceType ASSET_IMAGE_GITHUB_ORGS;
extern StaticResourceType ASSET_IMAGE_USER_AVATAR;
extern StaticResourceType ASSET_IMAGE_TABBAR_HOME;
extern StaticResourceType ASSET_IMAGE_ARROW_INDICATOR;
extern StaticResourceType ASSET_IMAGE_TABBAR_ALERT;
extern StaticResourceType ASSET_IMAGE_TABBAR_SEARCH;
extern StaticResourceType ASSET_IMAGE_TABBAR_HOME_FILLED;
extern StaticResourceType ASSET_IMAGE_TABBAR_ALERT_FILLED;
extern StaticResourceType ASSET_IMAGE_TABBAR_SEARCH_FILLED;
extern StaticResourceType ASSET_IMAGE_TOAST_INFO;
extern StaticResourceType ASSET_IMAGE_TOAST_SUCCESS;
extern StaticResourceType ASSET_IMAGE_TOAST_ERROR;
extern StaticResourceType ASSET_IMAGE_BOOK_COVER;

NSBundle * assetBundle(Class class);

#endif /* Assets_h */
