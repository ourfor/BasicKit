//
//  Timer.m
//  GithubApp
//
//  Created by ourfor on 2021/6/1.
//

#import "Timer.h"

inline NSMutableArray<Timer> * allTimers(void) {
    static dispatch_once_t token;
    static NSMutableArray<Timer> *timers;
    dispatch_once(&token, ^{
        timers = [NSMutableArray new];
    });
    return timers;
}

inline void setTimeout(TimeoutCallback fn, unsigned long duration) {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration), dispatch_get_main_queue(), fn);
}

inline Timer setInterval(IntervalCallback fn, unsigned long interval) {
    Timer timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    dispatch_source_set_event_handler(timer, fn);
    dispatch_resume(timer);
    [allTimers() addObject:timer];
    return timer;
}

inline void clearInterval(Timer timer) {
    dispatch_cancel(timer);
    [allTimers() removeObject:timer];
    timer = nil;
}
