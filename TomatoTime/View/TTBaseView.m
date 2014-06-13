//
//  TTBaseView.m
//  TomatoTime
//
//  Created by Sheldon on 14-6-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTBaseView.h"

@implementation TTBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0.95 alpha:1];
    }
    return self;
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
