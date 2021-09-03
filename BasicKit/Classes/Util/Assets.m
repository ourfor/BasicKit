//
//  Assets.m
//  GithubApp
//
//  Created by ourfor on 2021/5/29.
//

#import "Assets.h"

StaticResourceType ASSET_FONT_ARITAHEITI_MEDIUM = @"AritaHeiti-Medium";
StaticResourceType ASSET_FONT_FIRACODE_BOLD = @"FiraCode-Bold";
StaticResourceType ASSET_FONT_FIRACODE_LIGHT = @"FiraCode-Light";
StaticResourceType ASSET_FONT_FIRACODE_MEDIUM = @"FiraCode-Medium";
StaticResourceType ASSET_FONT_FIRACODE_REGULAR = @"FiraCode-Regular";
StaticResourceType ASSET_FONT_FIRACODE_RETINA = @"FiraCode-Retina";
StaticResourceType ASSET_FONT_FIRACODE_SEMIBOLD = @"FiraCode-SemiBold";
StaticResourceType ASSET_IMAGE_GITHUB_ICON = @"github";
StaticResourceType ASSET_IMAGE_GITHUB_REPOS = @"github_repositories";
StaticResourceType ASSET_IMAGE_GITHUB_ISSUES = @"github_issues";
StaticResourceType ASSET_IMAGE_GITHUB_REQS = @"github_pullrequests";
StaticResourceType ASSET_IMAGE_GITHUB_ORGS = @"github_organizations";
StaticResourceType ASSET_IMAGE_USER_AVATAR = @"icon_avatar";
StaticResourceType ASSET_IMAGE_TABBAR_HOME = @"tab_home";
StaticResourceType ASSET_IMAGE_TABBAR_ALERT = @"tab_alert";
StaticResourceType ASSET_IMAGE_TABBAR_SEARCH = @"tab_search";
StaticResourceType ASSET_IMAGE_TABBAR_HOME_FILLED = @"tab_home_filled";
StaticResourceType ASSET_IMAGE_TABBAR_ALERT_FILLED = @"tab_alert_filled";
StaticResourceType ASSET_IMAGE_TABBAR_SEARCH_FILLED = @"tab_search_filled";
StaticResourceType ASSET_IMAGE_ARROW_INDICATOR = @"icon_arrow";
StaticResourceType ASSET_IMAGE_TOAST_INFO = @"tip_info";
StaticResourceType ASSET_IMAGE_TOAST_SUCCESS = @"tip_success";
StaticResourceType ASSET_IMAGE_TOAST_ERROR = @"tip_error";
StaticResourceType ASSET_IMAGE_BOOK_COVER = @"book_cover";

inline NSBundle * assetBundle(Class class) {
    static NSBundle *asset;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSBundle *bundle = [NSBundle bundleForClass:class];
        asset = [NSBundle bundleWithURL:[bundle URLForResource:@"Asset" withExtension:@"bundle"]];
    });
    return asset;
}
