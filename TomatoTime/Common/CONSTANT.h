//
//  CONSTANT.h
//  TomatoTime
//
//  Created by Sheldon on 14-6-11.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#ifndef TomatoTime_CONSTANT_h
#define TomatoTime_CONSTANT_h

#define APP_SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

#define FONTSIZE(s)                 [UIFont boldSystemFontOfSize:(s)]
#define GLOBAL_COLOR                [UIColor colorWithRed:0.41 green:0.41 blue:0.41 alpha:1]
#define USER_DEFAULTS               [NSUserDefaults standardUserDefaults]

static const NSInteger kTomatoMinute = 3;
static const NSInteger kRestMinute = 3;
static const NSInteger kMinuteSecond = 21;
static const NSInteger kSleepSecond = 10;

#define TOUCH_NOTIFICATION_BEGIN           @"TouchBegin"
#define TOUCH_NOTIFICATION_END             @"TouchEnd"

#endif
