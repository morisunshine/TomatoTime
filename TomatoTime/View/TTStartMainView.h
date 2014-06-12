//
//  TTStartMainView.h
//  TomatoTime
//
//  Created by Sheldon on 14-6-12.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTCircleView;

@interface TTStartMainView : UIView

@property (nonatomic, retain) TTCircleView *circleView;
@property (nonatomic, retain) UILabel *textLabel;

@property (nonatomic, copy) void (^handler)();

@end
