//
//  TTCircleView.m
//  TomatoTime
//
//  Created by Sheldon on 14-5-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTCircleView.h"

NSInteger const kCircleLineWidth = 4;

@implementation TTCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (_trackLayer != nil) {
        return;
    }
    
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = self.bounds;
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    if (self.circleColor) {
        _trackLayer.strokeColor = self.circleColor.CGColor;
    } else {
        _trackLayer.strokeColor = [UIColor redColor].CGColor;
    }
    
    _trackLayer.contentsScale = [UIScreen mainScreen].scale;
    _trackLayer.lineCap = kCALineCapRound;
    _trackLayer.lineWidth = kCircleLineWidth;
    CGFloat progressWidth = self.bounds.size.width;
    CGFloat radius = progressWidth / 2 - kCircleLineWidth / 2;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:radius startAngle:(M_PI * -90 / 180) endAngle:(M_PI * 270 / 180) clockwise:YES];
    _trackLayer.path = [path CGPath];
    [self.layer addSublayer:_trackLayer];
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
