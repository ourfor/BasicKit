//
//  OHWatchView.m
//  BasicKitApp
//
//  Created by XuWang Real on 2022/2/12.
//  Copyright © 2022 曾谞旺. All rights reserved.
//

#import "OHWatchView.h"

@interface OHWatchView ()
@property (nonatomic, strong) UIView *secondPointerView;
@property (nonatomic, strong) UIView *minutePointerView;
@property (nonatomic, strong) UIView *hourPointerView;
@property (nonatomic, strong) UIView *dialView;
@property (nonatomic, strong) UIView *centerDotView;
@end

@implementation OHWatchView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _setupUI];
        [self _layout];
        [self _bind];
    }
    return self;
}

- (void)_setupUI {
    self.backgroundColor = UIColor.blackColor;
    [self addSubview:self.dialView];
    [self addSubview:self.hourPointerView];
    [self addSubview:self.minutePointerView];
    [self addSubview:self.secondPointerView];
    [self addSubview:self.centerDotView];
}


- (void)_layout {
    @weakify(self);
    [self.secondPointerView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(@2);
        make.height.equalTo(self).multipliedBy(0.6).with.offset(-10);
        make.center.equalTo(self);
    }];
    
    [self.minutePointerView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(@4);
        make.height.equalTo(self).multipliedBy(0.45);
        make.center.equalTo(self);
    }];
    
    [self.hourPointerView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.equalTo(@6);
        make.height.equalTo(self).multipliedBy(0.35);
        make.center.equalTo(self);
    }];
    
    [self.centerDotView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self);
        make.width.height.equalTo(12);
    }];
    
    [self.dialView remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.center.equalTo(self);
        make.width.equalTo(self).with.offset(-2);
        make.height.equalTo(self).with.offset(-2);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.dialView.layer.cornerRadius = self.dialView.frame.size.width / 2;
}

- (void)_bind {
    [NSTimer scheduledTimerWithTimeInterval:0.5f repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSDate *date = [[NSDate date] dateByAddingTimeInterval:1.0f];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *dateComponent = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
        CGFloat secondAngle = (2 * M_PI * dateComponent.second / 60) - M_PI;
        CGFloat minuteAngleOffset = (dateComponent.second / 60) * 2 * M_PI / 60;
        CGFloat minuteAngle = (2 * M_PI * dateComponent.minute / 60) + minuteAngleOffset - M_PI;
        CGFloat hourAngleOffset = (dateComponent.minute / 60) * 2 * M_PI / 12;
        CGFloat hourAngle = (2 * M_PI * dateComponent.hour / 12) + hourAngleOffset - M_PI;
        [UIView animateWithDuration:1.0f animations:^{
            self.secondPointerView.transform = CGAffineTransformMakeRotation(secondAngle);
            self.minutePointerView.transform = CGAffineTransformMakeRotation(minuteAngle);
            self.hourPointerView.transform = CGAffineTransformMakeRotation(hourAngle);
        } completion:^(BOOL finished) {
            [self.secondPointerView.layer addAnimation:[self _rotateWithDuration:60 startAngle:secondAngle] forKey:@"rotate"];
            [self.minutePointerView.layer addAnimation:[self _rotateWithDuration:60 * 60 startAngle:minuteAngle] forKey:@"rotate"];
            [self.hourPointerView.layer addAnimation:[self _rotateWithDuration:12 * 60 * 60 startAngle:hourAngle] forKey:@"rotate"];
        }];
    }];
}

- (CABasicAnimation *)_rotateWithDuration:(CGFloat)duration startAngle:(CGFloat)startAngle {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @(startAngle);
    animation.toValue = @(startAngle + 2 * M_PI);
    animation.removedOnCompletion = NO;
    return animation;
}

#pragma mark Getter
- (UIView *)secondPointerView {
    BeginLazyPropInit(secondPointerView)
    secondPointerView = [[UIView alloc] init];
    secondPointerView.backgroundColor = UIColor.orangeColor;
    secondPointerView.layer.cornerRadius = 1;
    secondPointerView.layer.anchorPoint = CGPointMake(0.5, 0.15);
    EndLazyPropInit(secondPointerView)
}

- (UIView *)minutePointerView {
    BeginLazyPropInit(minutePointerView)
    minutePointerView = [[UIView alloc] init];
    minutePointerView.backgroundColor = UIColor.greenColor;
    minutePointerView.layer.cornerRadius = 1;
    minutePointerView.layer.anchorPoint = CGPointMake(0.5, 0.15);
    EndLazyPropInit(minutePointerView)
}

- (UIView *)hourPointerView {
    BeginLazyPropInit(hourPointerView)
    hourPointerView = [[UIView alloc] init];
    hourPointerView.backgroundColor = UIColor.redColor;
    hourPointerView.layer.anchorPoint = CGPointMake(0.5, 0.15);
    hourPointerView.layer.cornerRadius = 2;
    EndLazyPropInit(hourPointerView)
}

- (UIView *)dialView {
    BeginLazyPropInit(dialView)
    UIImage *image = [UIImage imageNamed:@"fruit_3"];
    dialView = [[UIImageView alloc] initWithImage:image];
    dialView.backgroundColor = UIColor.whiteColor;
    EndLazyPropInit(dialView)
}

- (UIView *)centerDotView {
    BeginLazyPropInit(centerDotView)
    UIImage *image = [UIImage imageNamed:@"fruit_2"];
    centerDotView = [[UIImageView alloc] initWithImage:image];
    centerDotView.layer.cornerRadius = 6;
    EndLazyPropInit(centerDotView)
}
@end
