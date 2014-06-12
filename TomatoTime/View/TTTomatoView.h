//
//  TTTomatoView.h
//  TomatoTime
//
//  Created by Sheldon on 14-6-12.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTCircleView;
@class TTProgressView;

@interface TTTomatoView : UIView
{
    NSTimer *timer_;
    NSInteger minuteCount_;
}

@property (nonatomic, retain) TTCircleView *circleView;
@property (nonatomic, retain) TTProgressView *progressView;
@property (nonatomic, copy) void (^handler)();

@end
