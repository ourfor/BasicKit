//
//  Timer.h
//  GithubApp
//
//  Created by ourfor on 2021/6/1.
//

#import <Foundation/Foundation.h>

#define TIME_UNIT_SEC NSEC_PER_SEC
#define TIME_UNIT_MSEC NSEC_PER_MSEC
#define TIME_UNIT_USEC NSEC_PER_USEC

typedef dispatch_source_t Timer;
typedef void (^TimeoutCallback)(void);
typedef void (^IntervalCallback)(void);

void setTimeout(TimeoutCallback fn, unsigned long duration);
Timer setInterval(IntervalCallback fn, unsigned long duration);
void clearInterval(Timer timer);
NSMutableArray<Timer> * allTimers(void);
