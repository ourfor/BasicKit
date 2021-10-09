//
//  Monitor.h
//  BasicKit
//
//  Created by XuWang Real on 2021/9/22.
//

#import <Foundation/Foundation.h>

typedef void (^MonitorHandler)(NSString *event, NSDictionary *params);

void monitor(NSString *event, NSDictionary *params);
void setMonitorHandler(MonitorHandler handler);
