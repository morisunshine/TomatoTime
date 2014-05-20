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
        [self addSubview:self.totoalView];
        [self addSubview:self.progressView];
    }
    return self;
}

#pragma mark - Getters -

- (UIView *)totoalView
{
    if (!_totoalView) {
        _totoalView = [[UIView alloc] initWithFrame:self.bounds];
        _totoalView.layer.cornerRadius = 4;
        _totoalView.backgroundColor = [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1];
    }
    
    return _totoalView;
}

- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:self.bounds];
        _progressView.layer.cornerRadius = 4;
        _progressView.backgroundColor = [UIColor colorWithRed:0.41 green:0.41 blue:0.41 alpha:1];
    }
    
    return _progressView;
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
