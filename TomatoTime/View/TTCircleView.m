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

- (id)initWithFrame:(CGRect)frame circleMode:(TTCircleViewMode)circleMode
{
    self = [super initWithFrame:frame];
    if (self) {
        self.circleMode = circleMode;
        [self setupView];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

#pragma mark - Private Methods -

- (void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    
    if (self.circleMode == TTCircleViewModeLine) {
        [self.layer addSublayer:self.trackLayer];
    } else {
        self.layer.cornerRadius = self.bounds.size.width / 2;
    }
    
    [self addSubview:self.titleLabel];
}

#pragma mark - Getters -

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                0 + CGRectGetHeight(self.bounds) / 2 - 20,
                                                                CGRectGetWidth(self.bounds),
                                                                40)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:22];
        _titleLabel.textColor = [UIColor colorWithRed:0.41 green:0.41 blue:0.41 alpha:1];
    }
    
    return _titleLabel;
}

- (CAShapeLayer *)trackLayer
{
    if (!_trackLayer) {
        
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.frame = self.bounds;
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1].CGColor;
        _trackLayer.strokeColor = [UIColor redColor].CGColor;
        _trackLayer.contentsScale = [UIScreen mainScreen].scale;
        _trackLayer.lineCap = kCALineCapRound;
        _trackLayer.lineWidth = kCircleLineWidth;
        CGFloat progressWidth = self.bounds.size.width;
        CGFloat radius = progressWidth / 2 - kCircleLineWidth / 2;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
                                                            radius:radius
                                                        startAngle:(- M_PI / 2)
                                                          endAngle:(M_PI * 3 / 2)
                                                         clockwise:YES];
        _trackLayer.path = [path CGPath];
        [self.layer addSublayer:_trackLayer];
    }
    
    return _trackLayer;
}

#pragma mark - Setters -

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    self.titleLabel.text = titleString;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    self.titleLabel.textColor = titleColor;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    
    if (self.circleMode == TTCircleViewModeFill) {
        self.layer.backgroundColor = circleColor.CGColor;
    } else {
        self.trackLayer.strokeColor = circleColor.CGColor;
    }
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
