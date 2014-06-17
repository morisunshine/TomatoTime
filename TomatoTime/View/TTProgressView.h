//
//  TTProgress.h
//  TomatoTime
//
//  Created by Sheldon on 14-5-20.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTProgressView : UIView
{
    NSTimer *_timer;
    NSInteger _count;
}

@property (nonatomic, retain) UIView *totoalView;
@property (nonatomic, retain) UIView *progressView;
@property (nonatomic, retain) UILabel *countLabel;

- (void)oneSecondAnimationsWithLeft:(BOOL)left;
- (void)stopSecond;

@end
