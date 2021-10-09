//
//  Track.h
//  BasicKit
//
//  Created by XuWang Real on 2021/9/22.
//

#import <Foundation/Foundation.h>

typedef void (^TrackHandler)(NSString *event, NSDictionary *params);
void track(NSString *event, NSDictionary *params);
void setTrackHandler(TrackHandler newHandler);
