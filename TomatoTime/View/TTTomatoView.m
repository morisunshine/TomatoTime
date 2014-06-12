//
//  TTTomatoView.m
//  TomatoTime
//
//  Created by Sheldon on 14-6-12.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTTomatoView.h"
#import "TTProgressView.h"
#import "TTCircleView.h"

@implementation TTTomatoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self setupView];
    }
    return self;
}

#pragma mark - Private Methods -

- (void)setupView
{
    minuteCount_ = 26;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.circleView];
    [self addSubview:self.progressView];
    
    timer_ = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(updateMinuteCount) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer_ forMode:NSDefaultRunLoopMode];
    [timer_ fire];
}

#pragma mark - Getters -

- (TTCircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[TTCircleView alloc] initWithFrame:CGRectMake(0, 100, 150, 150)];
        _circleView.circleMode = TTCircleViewModeFill;
        _circleView.titleColor = [UIColor whiteColor];
        _circleView.center = CGPointMake(self.center.x, _circleView.center.y);
        _circleView.circleColor = [UIColor colorWithRed:0.87 green:0.32 blue:0.24 alpha:1];
        _circleView.userInteractionEnabled = YES;
    }
    
    return _circleView;
}

- (TTProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[TTProgressView alloc] initWithFrame:CGRectMake(0, 300, 150, 25)];
        _progressView.center = CGPointMake(self.center.x, _progressView.center.y);
        [_progressView oneSecondAnimationsWithLeft:YES];
    }
    
    return _progressView;
}

#pragma mark - NSTimer -

- (void)updateMinuteCount
{
    minuteCount_ --;
    self.circleView.titleString = [NSString stringWithFormat:@"%d", minuteCount_];
    if (minuteCount_ == 0) {
        [timer_ invalidate];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
