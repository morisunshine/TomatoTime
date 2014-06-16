//
//  TTTomatoView.h
//  TomatoTime
//
//  Created by Sheldon on 14-6-12.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTBaseView.h"

@class TTCircleView;
@class TTProgressView;

@interface TTTomatoView : TTBaseView
{
    NSTimer *timer_;
    NSInteger maxMinute_;
    
}

@property (nonatomic, retain) TTCircleView *circleView;
@property (nonatomic, retain) UIButton *deleteBtn;
@property (nonatomic, retain) TTProgressView *progressView;
@property (nonatomic, retain) UIScrollView *backgroundScrollView;
@property (nonatomic, retain) UIColor *circleColor;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, copy) void(^endHandler)();
@property (nonatomic, copy) void(^endTapHandler)();
@property (nonatomic, copy) void(^giveUpHandler)();

- (id)initWithFrame:(CGRect)frame maxMinute:(NSInteger)maxMinute;

@end
