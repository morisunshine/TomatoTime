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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchBegin:) name:TOUCH_NOTIFICATION_BEGIN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchEnd:) name:TOUCH_NOTIFICATION_END object:nil];
    self.userInteractionEnabled = YES;
    [self addSubview:self.backgroundScrollView];
    [self.backgroundScrollView addSubview:self.circleView];
    [self.backgroundScrollView addSubview:self.progressView];
    
    timer_ = [NSTimer timerWithTimeInterval:kMinuteSecond target:self selector:@selector(updateMinuteCount) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer_ forMode:NSDefaultRunLoopMode];
    [timer_ fire];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPressGestureRecognizer.minimumPressDuration = 3;
    [self.circleView addGestureRecognizer:longPressGestureRecognizer];
    
    [self performSelector:@selector(longTimeNoTouch) withObject:nil afterDelay:kSleepSecond];
}

#pragma mark - Setters -

- (void)setTitleString:(NSString *)titleString
{
    [self.circleView setState:TTCircleViewStateNormal title:titleString];
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self.circleView setState:TTCircleViewStateNormal color:circleColor];
}

#pragma mark - Getters -

- (UIScrollView *)backgroundScrollView
{
    if (!_backgroundScrollView) {
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -30, 100, 24)];
        tipLabel.centerX = self.width / 2;
        tipLabel.text = @"Hasta la vista";
        tipLabel.font = FONTSIZE(14);
        tipLabel.textColor = GLOBAL_COLOR;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        _backgroundScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _backgroundScrollView.backgroundColor = self.backgroundColor;
        _backgroundScrollView.alwaysBounceVertical = YES;
        [_backgroundScrollView addSubview:tipLabel];
    }
    
    return _backgroundScrollView;
}

- (TTCircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[TTCircleView alloc] initWithFrame:CGRectMake(0, 100, 150, 150) circleMode:TTCircleViewModeFill];
        _circleView.needHighlighted = YES;
        _circleView.titleColor = [UIColor whiteColor];
        _circleView.center = CGPointMake(self.center.x, _circleView.center.y);
        [_circleView setState:TTCircleViewStateNormal color:[UIColor colorWithRed:0.87 green:0.32 blue:0.24 alpha:1]];
        [_circleView setState:TTCircleViewStateHighlighted title:@"长按3秒，放弃番茄"];
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
    
    [self.circleView setState:TTCircleViewStateNormal title:[NSString stringWithFormat:@"%d", maxMinute_]];
    
    if (maxMinute_ == 0) {
        [timer_ invalidate];
        if (self.endHandler) {
            self.endHandler();
        }
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTaped:)];
        [self.circleView addGestureRecognizer:tapGestureRecognizer];
    }
}

- (void)longTimeNoTouch
{
    NSLog(@"很久没有点击了！");
    [UIView animateWithDuration:1 animations:^{
        self.circleView.trackLayer.fillColor = [UIColor blackColor].CGColor;
        self.backgroundScrollView.backgroundColor = [UIColor blackColor];
        self.circleView.titleColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
        self.circleView.circleMode = TTCircleViewModeLine;
    }];
}

#pragma mark - Actions -

- (IBAction)longPressAction:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始");
        if (self.giveUpHandler) {
            self.giveUpHandler();
        }
    }
}

- (IBAction)endTaped:(id)sender
{
    if (self.endTapHandler) {
        self.endTapHandler();
    }
}

#pragma mark - Notification -

- (void)touchBegin:(NSNotification *)notification
{
    NSLog(@"点击!");
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(longTimeNoTouch) object:nil];
}

- (void)touchEnd:(NSNotification *)notification
{
    NSLog(@"点击结束!");
    [UIView animateWithDuration:1 animations:^{
        self.backgroundScrollView.backgroundColor = self.backgroundColor;
        self.circleView.titleColor = [UIColor whiteColor];
        self.circleView.circleMode = TTCircleViewModeFill;
        self.circleView.circleColor = self.circleColor;
    }];
    [self performSelector:@selector(longTimeNoTouch) withObject:nil afterDelay:kSleepSecond];
}

@end
