//
//  TTViewController.m
//  TomatoTime
//
//  Created by Sheldon on 14-5-13.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "TTViewController.h"
#import "TTCircleView.h"
#import "TTProgressView.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TTCircleView *circleView = [[TTCircleView alloc] initWithFrame:CGRectMake(0, 100, 150, 150)];
    circleView.center = CGPointMake(self.view.center.x, circleView.center.y);
    circleView.circleColor = [UIColor colorWithRed:0.87 green:0.32 blue:0.24 alpha:1];
    circleView.titleString = @"开始";
    
    TTProgressView *progressView = [[TTProgressView alloc] initWithFrame:CGRectMake(72, 300, 175, 2)];
    
    [self.view addSubview:circleView];
    [self.view addSubview:progressView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
