//
//  Track.m
//  BasicKit
//
//  Created by XuWang Real on 2021/9/22.
//

#import "Track.h"

static TrackHandler handler;
void track(NSString *event, NSDictionary *params) {
    if (handler) {
        handler(event, params);
    }
}

void setTrackHandler(TrackHandler newHandler) {
    handler = [newHandler copy];
}
