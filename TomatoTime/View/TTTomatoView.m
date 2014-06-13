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

- (id)initWithFrame:(CGRect)frame maxMinute:(NSInteger)maxMinute
{
    self = [super initWithFrame:frame];
    if (self) {
        maxMinute_ = maxMinute;
        [self setupView];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

#pragma mark - Private Methods -

- (void)setupView
{
    [self addSubview:self.circleView];
    [self addSubview:self.progressView];
    
    timer_ = [NSTimer timerWithTimeInterval:20 target:self selector:@selector(updateMinuteCount) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer_ forMode:NSDefaultRunLoopMode];
    [timer_ fire];
}

#pragma mark - Setters -

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    self.circleView.titleString = titleString;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    self.circleView.circleColor = circleColor;
}

#pragma mark - Getters -

- (TTCircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[TTCircleView alloc] initWithFrame:CGRectMake(0, 100, 150, 150) circleMode:TTCircleViewModeFill];
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
    maxMinute_ --;
    
    self.circleView.titleString = [NSString stringWithFormat:@"%d", maxMinute_];
    
    if (maxMinute_ == 0) {
        [timer_ invalidate];
        if (self.endHandler) {
            self.endHandler();
        }
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTaped:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
}

#pragma mark - Actions -

- (IBAction)endTaped:(id)sender
{
    if (self.endTapHandler) {
        self.endTapHandler();
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
