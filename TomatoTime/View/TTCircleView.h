//
//  TTCircleView.h
//  TomatoTime
//
//  Created by Sheldon on 14-5-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TTCircleViewMode) {
    TTCircleViewModeLine,      //有线的圆
    TTCircleViewModeFill       //实体的圆
};

typedef NS_ENUM(NSInteger, TTCircleViewState) {
    TTCircleViewStateNormal,       //未点击状态
    TTCircleViewStateHighlighted   //高亮状态
};

@interface TTCircleView : UIControl
{
    UIColor *normalColor_;
    UIColor *highlightedColor_;
    UIImage *normalImage_;
    UIImage *highlightedImage_;
    NSString *normalTitle_;
    NSString *highlighedTitle_;
    UILongPressGestureRecognizer *longPressGestureRecognizer_;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) CAShapeLayer *trackLayer;
@property (nonatomic, retain) UIColor *circleColor;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIImageView *trashImageView;
@property (nonatomic) TTCircleViewMode circleMode;

- (id)initWithFrame:(CGRect)frame circleMode:(TTCircleViewMode)circleMode;
- (void)setState:(TTCircleViewState)state color:(UIColor *)color;
- (void)setState:(TTCircleViewState)state image:(UIImage *)image;
- (void)setState:(TTCircleViewState)state title:(NSString *)title;

@end
