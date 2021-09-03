//
//  Logger.m
//  GithubApp
//
//  Created by ourfor on 2021/6/4.
//

#import "Logger.h"

@implementation Logger

+ (instancetype)sharedInstance {
    static Logger *log;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        log = [[Logger alloc] init];
    });
    return log;
}

- (Format)info {
    return [self log:@"INFO"];
}

- (Format)warn {
    return [self log:@"WARN"];
}

- (Format)error {
    return [self log:@"ERROR"];
}

- (Format)log:(NSString *)level {
    return ^(NSString *format, ...) {
        NSString *levelString = [NSString stringWithFormat:@"[%@] ", level.uppercaseString];
        NSString *infoFormat = [levelString stringByAppendingString:format];
        va_list args;
        va_start(args, format);
            NSLogv(infoFormat, args);
        va_end(args);
    };
}

@end
