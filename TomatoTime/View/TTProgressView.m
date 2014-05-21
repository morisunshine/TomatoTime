//
//  TTProgress.m
//  TomatoTime
//
//  Created by Sheldon on 14-5-20.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTProgressView.h"

@implementation TTProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.countLabel];
        [self addSubview:self.totoalView];
        [self addSubview:self.progressView];
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountLabel) userInfo:nil repeats:YES];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer fire];
    }
    return self;
}

#pragma mark - Getters -

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _countLabel.text = @"1";
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.textColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1];
        _countLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    
    return _countLabel;
}

- (UIView *)totoalView
{
    if (!_totoalView) {
        _totoalView = [[UIView alloc] initWithFrame:CGRectMake(0, 14, CGRectGetWidth(self.bounds), 2)];
        _totoalView.layer.cornerRadius = 4;
        _totoalView.backgroundColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1];
    }
    
    return _totoalView;
}

- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 0, 2)];
        _progressView.layer.cornerRadius = 4;
        _progressView.backgroundColor = [UIColor colorWithRed:0.87 green:0.31 blue:0.23 alpha:1];
    }
    
    return _progressView;
}

#pragma mark - Animations -

- (void)oneSecondAnimationsWithLeft:(BOOL)left
{
    if (left) {
        [UIView animateWithDuration:60 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.countLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) - 12, 0, 20, 12);
            self.progressView.frame = CGRectMake(0, 14, CGRectGetWidth(self.bounds), 2);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)updateCountLabel
{
    static NSInteger count = 0;
    count++;
    
    self.countLabel.text = [NSString stringWithFormat:@"%i",count];
    
    if (count == 60) {
        [_timer invalidate];
    }
}

@end
