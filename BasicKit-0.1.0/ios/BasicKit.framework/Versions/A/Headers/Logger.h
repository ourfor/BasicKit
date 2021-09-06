//
//  Logger.h
//  GithubApp
//
//  Created by ourfor on 2021/6/4.
//

#import <Foundation/Foundation.h>

typedef void (^Format)(NSString *format, ...);

@interface Logger : NSObject
+ (instancetype)sharedInstance;
- (Format) info;
- (Format) warn;
- (Format) error;
@end
