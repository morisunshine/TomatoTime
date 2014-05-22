//
//  TTViewController.m
//  TomatoTime
//
//  Created by Sheldon on 14-5-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTTomatoViewController.h"
#import "TTCircleView.h"
#import "TTProgressView.h"

@interface TTTomatoViewController ()
{
    NSTimer *timer_;
    NSInteger minuteCount_;
}

@property (nonatomic, retain) TTCircleView *circleView;
@property (nonatomic, retain) TTProgressView *progressView;

@end

@implementation TTTomatoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    minuteCount_ = 26;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.circleView];
    [self.view addSubview:self.progressView];
    
    timer_ = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(updateMinuteCount) userInfo:nil repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:timer_ forMode:NSDefaultRunLoopMode];
    [timer_ fire];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters -

- (TTCircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[TTCircleView alloc] initWithFrame:CGRectMake(0, 100, 150, 150)];
        _circleView.circleMode = TTCircleViewModeFill;
        _circleView.titleColor = [UIColor whiteColor];
        _circleView.center = CGPointMake(self.view.center.x, _circleView.center.y);
        _circleView.circleColor = [UIColor colorWithRed:0.87 green:0.32 blue:0.24 alpha:1];
        _circleView.userInteractionEnabled = YES;
    }
    
    return _circleView;
}

- (TTProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[TTProgressView alloc] initWithFrame:CGRectMake(0, 300, 150, 25)];
        _progressView.center = CGPointMake(self.view.center.x, _progressView.center.y);
        [_progressView oneSecondAnimationsWithLeft:YES];
    }
    
    return _progressView;
}

#pragma mark - Actions -

- (void)updateMinuteCount
{
    minuteCount_ --;
    self.circleView.titleString = [NSString stringWithFormat:@"%d", minuteCount_];
    if (minuteCount_ == 0) {
        [timer_ invalidate];
    }
}

@end
