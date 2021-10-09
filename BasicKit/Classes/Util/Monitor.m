//
//  Monitor.m
//  BasicKit
//
//  Created by XuWang Real on 2021/9/22.
//

#import "Monitor.h"

static MonitorHandler handler;
void monitor(NSString *event, NSDictionary *params) {
    if (handler) {
        handler(event, params);
    }
}

void setMonitorHandler(MonitorHandler newHandler) {
    handler = [newHandler copy];
}
