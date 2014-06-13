//
//  TTBaseView.h
//  TomatoTime
//
//  Created by Sheldon on 14-6-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTBaseView : UIView

@property (nonatomic, copy) void (^handler)();

@end
