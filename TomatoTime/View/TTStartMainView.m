//
//  TTStartMainView.m
//  TomatoTime
//
//  Created by Sheldon on 14-6-12.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTStartMainView.h"
#import "TTCircleView.h"

@implementation TTStartMainView

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
    [self addSubview:self.circleView];
    [self addSubview:self.textLabel];
}

#pragma mark - Getters -

- (TTCircleView *)circleView
{
    if (!_circleView) {
        _circleView = [[TTCircleView alloc] initWithFrame:CGRectMake(0, 100, 150, 150)];
        _circleView.center = CGPointMake(self.center.x, _circleView.center.y);
        _circleView.circleColor = [UIColor colorWithRed:0.87 green:0.32 blue:0.24 alpha:1];
        _circleView.titleString = @"开始";
        [_circleView addTarget:self action:@selector(startToTomato:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _circleView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 189, 150)];
        _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.center = CGPointMake(self.center.x, _textLabel.center.y);
        _textLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1];
        _textLabel.font = [UIFont boldSystemFontOfSize:16];
        _textLabel.text = @"YESTERDAY,\n YOU SAID TOMORROW";
    }
    
    return _textLabel;
}

#pragma mark - Actions -

- (IBAction)startToTomato:(UITapGestureRecognizer *)sender
{
    POPSpringAnimation *startAnimation = [POPSpringAnimation animation];
    startAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    startAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(APP_SCREEN_WIDTH / 2, APP_SCREEN_HEIGHT / 2)];
    startAnimation.springBounciness = 20.0;
    startAnimation.springSpeed = 20.0;
    startAnimation.completionBlock = ^(POPAnimation *animation, BOOL finish) {
        if (finish) {
            if (self.handler) {
                self.handler();
            }
        }
    };
    
    [self.circleView pop_addAnimation:startAnimation forKey:@"pop"];
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
