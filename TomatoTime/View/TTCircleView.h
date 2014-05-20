//
//  TTCircleView.h
//  TomatoTime
//
//  Created by Sheldon on 14-5-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCircleView : UIView
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    UILabel *_titleLabel;
}

@property (nonatomic, retain) CAShapeLayer *progressLayer;
@property (nonatomic, retain) UIBezierPath *progressPath;

@property (nonatomic, assign) UIColor *circleColor;
@property (nonatomic, retain) NSString *titleString;

@end
