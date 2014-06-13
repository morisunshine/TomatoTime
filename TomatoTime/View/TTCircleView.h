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

@interface TTCircleView : UIView

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) CAShapeLayer *trackLayer;
@property (nonatomic, retain) UIColor *circleColor;
@property (nonatomic, retain) NSString *titleString;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic) TTCircleViewMode circleMode;

- (id)initWithFrame:(CGRect)frame circleMode:(TTCircleViewMode)circleMode;

@end
